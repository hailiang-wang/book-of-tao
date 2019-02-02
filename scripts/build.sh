#! /bin/bash 
###########################################
#
###########################################

# constants
baseDir=$(cd `dirname "$0"`;pwd)
rootDir=$(cd `dirname "$baseDir"`;pwd)
BOOK_NAME=道德经注
sourceDir=$rootDir/src
buildDir=$rootDir/_build
DATE_WITH_TIME=`date "+%Y-%m-%d-%H%M%S"`

# functions
function resolve_log(){
    cd $baseDir/..
    if [ ! -f dist/main.log ]; then
        touch dist/main.log
    fi
}

function generate_tex_from_markdown(){
    cd $buildDir
    for x in `find . -name "*.md"`; do
        echo "compiling $x to tex ..."
        pandoc \
            -t latex  \
            --bibliography $sourceDir/bibliography.bib \
            --csl $sourceDir/template.csl \
            --latex-engine=xelatex \
            -V mainfont=Hei \
            --listings $x \
            -o ${x/\.md/\.tex} \
            # --template=$sourceDir/pandoc-tmpl.latex \
    done;
}

function is_directory_change(){
    # $1 dirpath $2 md5 file
    md5_old=''
    md5_new=''
    rebuilt=0

    basedir_name=$(cd `dirname "$2"`;pwd)
    mkdir -p $basedir_name

    if [ -f $2 ]; then
        md5_old=`cat $2`
    fi
    md5_new=`get_directroy_md5 $1`

    if [ -z "$md5_old" ]; then
        echo "md5_old zero"
        echo $md5_new > $2
        rebuilt=0
    elif [ "$md5_old" == "$md5_new" ]; then
        rebuilt=1
    else 
        echo $md5_new > $2
        rebuilt=0
    fi

    return $rebuilt
}

function get_directroy_md5(){
    md5_val=`ls -alR $1 | md5sum`
    echo $md5_val
}

function build(){
    cd $rootDir

    if [ ! -d .tmp ]; then
        mkdir .tmp
    fi

    is_directory_change $rootDir/src $rootDir/.tmp/source_md5
    if [ "$?" == "1" ]; then
        echo "sources are not changed, abort rebuilt."
        exit 1
    fi

    if [ -d $buildDir ]; then
        echo "Delete build dir ..."
        rm -rf $buildDir
    fi
    cp -rf $sourceDir $buildDir
    cd $buildDir

    # generate tex files with markdowns
    generate_tex_from_markdown

    # build twice to generate table of contents properly 
    xelatex -output-directory=$baseDir/../dist/ main.tex

    if [ $? -eq 0 ]; then
        xelatex -output-directory=$baseDir/../dist/ main.tex
        # xelatex -output-directory=$baseDir/../dist/ main.tex
        # xelatex -output-directory=$baseDir/../dist/ main.tex
    else
        exit 1
    fi

    if [ $? -eq 0 ]; then
        cd $baseDir/../dist
        cp main.pdf $BOOK_NAME-$DATE_WITH_TIME.pdf
        cp main.pdf ../docs/book-of-tao.pdf
        echo "generated " dist/$BOOK_NAME-$DATE_WITH_TIME.pdf
        echo "done."
    fi

    mkdir -p $rootDir/.tmp
    md5_new=`get_directroy_md5 $rootDir/src`
    echo $md5_new > $rootDir/.tmp/source_md5
}

# main 
[ -z "${BASH_SOURCE[0]}" -o "${BASH_SOURCE[0]}" = "$0" ] || return
resolve_log
build