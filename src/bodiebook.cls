%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LaTeX BOOK Template
%% Template by Wd, <wd20060220@gmail.com>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{bodiebook}[2014/11/16 v1.0 Tsinghua University Wd]

\LoadClass[10.5pt,fancyhdr,openany,a4paper]{book}
\RequirePackage{etex}
\reserveinserts{28}

%=============================== Language ==========================================%
%=================================================================================%
\usepackage{xeCJK}

%=============================== Fonts ==========================================%
%=================================================================================%

\usepackage[normalem]{ulem}
\usepackage{fontspec}
\useunder{\uline}{\ul}{}
\RequirePackage{amsfonts}

%\RequirePackage[utf8]{inputenc}
\RequirePackage{kpfonts}
\RequirePackage{fontspec,unicode-math}

%\setmainfont[Ligatures=TeX]{Times New Roman}
\setmathfont[
    Path=fonts/,
    Ligatures=TeX]{xits-math.otf}
\setCJKmainfont[Path=fonts/]{SourceHanSansCN-Normal.otf}
\parindent 2em              % 段首缩进

%Font size customize
\newcommand{\fontsizec}[1]{\fontsize{#1}{\baselineskip}\selectfont}

\usepackage{libertine}
\usepackage{pgf} % for the calculation
% \libcirc and \libcircblk display their '0' if the parameter is out of range
\newcommand{\libcirc}[1]{\pgfmathparse{
    ifthenelse(#1 > 0 && #1 < 21, Hex(9311+#1), Hex(9450)
    }\libertineGlyph{uni\pgfmathresult}}
\newcommand{\libcircdbl}[1]{\pgfmathparse{Hex(9460+#1)}\libertineGlyph{uni\pgfmathresult}}
\newcommand{\libcircblk}[1]{\pgfmathparse{
    ifthenelse(#1 > 0 && #1 < 11, Hex(10101+#1),
        ifthenelse(#1 > 10 && #1 < 21, Hex(9450-10+#1),
            Hex(9471)
        )
    )
    }\libertineGlyph{uni\pgfmathresult}}

\newcommand{\juncirc}[1]{{\fontspec[Ligatures=Discretionary]{Junicode}[#1]}}
\newcommand{\juncircdbl}[1]{{\fontspec[Ligatures=Discretionary]{Junicode}[[#1]]}}
\newcommand{\juncircblk}[1]{{\fontspec[Ligatures=Discretionary]{Junicode}<#1>}}


%\RequirePackage{times,txfonts}  %times new roman

%=============================== Math ============================================%
%=================================================================================%

\RequirePackage{amsmath,amsthm, mathrsfs}
% \RequirePackage[mathstyleoff]{breqn}% a math package
\usepackage{eqnarray}
\usepackage[linesnumbered,lined,ruled,vlined,commentsnumbered]{algorithm2e}

\newenvironment{megaalgorithm}[1][h]
  {\renewcommand{\algorithmcfname}{算法}% Update algorithm name
   \begin{algorithm}[#1]%
  }{\end{algorithm}}

\newtheorem{definition}{{定义}}
%=============================== Page Layout =====================================%
%=================================================================================%

\RequirePackage{geometry}
\RequirePackage{multicol}
\RequirePackage[newparttoc]{titlesec}
\RequirePackage{titletoc,shorttoc} %style of titles and table of contents
\RequirePackage{fancyhdr} %header and footer
\RequirePackage{indentfirst}

%=============================== Markdown Settings ==================================%
%=================================================================================%
% https://github.com/jgm/pandoc/pull/1571
\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}
\usepackage{listings}
\usepackage{color}

%=============================== Source Code Styles ==================================%
%=================================================================================%
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

% https://tex.stackexchange.com/questions/31349/how-to-align-comments-with-lstlistings
\usepackage{zref-savepos}% http://ctan.org/pkg/zref
\makeatletter
% Taken from: https://tex.stackexchange.com/a/69076/5764
% \zsaveposx is defined since 2011/12/05 v2.23 of zref-savepos
\@ifundefined{zsaveposx}{\let\zsaveposx\zsavepos}{}
\makeatother
\newcounter{hposcnt}
\renewcommand*{\thehposcnt}{hpos\number\value{hposcnt}}
\newcommand*{\SP}{% set position
  \stepcounter{hposcnt}%
  \zsaveposx{\thehposcnt s}%
}
\makeatletter
\newcommand*{\UP}{% use previous position
  \zsaveposx{\thehposcnt u}%
  \zref@refused{\thehposcnt s}%
  \zref@refused{\thehposcnt u}%
  \kern\zposx{\thehposcnt s}sp\relax
  \kern-\zposx{\thehposcnt u}sp\relax
}
\makeatother

\lstset{frame=single,
  language=Python,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=fullflexible,
  basicstyle={\small\ttfamily},
  numbers=none,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=false,
  breakatwhitespace=true,
  keepspaces=true,
  tabsize=2,
  mathescape
}

\renewcommand{\lstlistingname}{代码}% Listing -> Algorithm
\renewcommand{\lstlistlistingname}{\lstlistingname 集合}%

%=============================== Floating Objects ================================%
%=================================================================================%

\RequirePackage{makecell,array} % tables
\RequirePackage{graphicx,multirow,bm,subfig,picinpar}% figures
\RequirePackage[figuresright]{rotating}
\RequirePackage{longtable,multirow}
\RequirePackage{supertabular}
\RequirePackage[online]{threeparttable}
\RequirePackage{booktabs,dcolumn,tabu}% three lines table
\RequirePackage{tikz}%drawing figures
\newcolumntype{,}{D{,}{}{-1}}
\newcolumntype{.}{D{.}{.}{-1}}
\def\hed#1{\multicolumn{1}{c}{#1}}
\def\mur#1{\multirow{1}{*}{#1}}
\RequirePackage{caption,floatrow,calc}

%=============================== Other Settings ==================================%
%=================================================================================%
\definecolor{darkblue}{HTML}{005C8E}

\RequirePackage{ifthen}%logitic judgements
\RequirePackage{enumitem}
\RequirePackage{indentfirst,lettrine}%indent first, lettrine effect
\RequirePackage[nottoc]{tocbibind}%add references into toc
\RequirePackage[pdfstartview=FitH,
                CJKbookmarks=true,
                bookmarksnumbered=true,
                bookmarksopen=true,
                colorlinks,
                pdfborder=001,   %color borders
                linkcolor=black,
                anchorcolor=black,
                citecolor=darkblue]{hyperref} %bookmarks
\usepackage[square,sort,comma,numbers,super]{natbib}


%============ Basic Layout Settings (themes and colors) ==========================%
%=================================================================================%

% loads a color scheme
\newcommand*{\wdtexbookcolor}[1]{
  \RequirePackage{wdtexbookcolor#1}}

% loads a style scheme
\newcommand*{\wdtexbooktheme}[1]{
  \RequirePackage{wdtexbooktheme#1}}


%=========================== Refernce Settings====================================%
%=================================================================================%

%\makeatletter
%\def\@cite#1#2{\textsuperscript{[{#1\if@tempswa , #2\fi}]}}
%\makeatother

%======================= Table and Figure Settings================================%
%=================================================================================%
\newcommand{\PreserveBackslash}[1]{\let\temp=\\#1\let\\=\temp}
\newcolumntype{C}[1]{>{\PreserveBackslash\centering}p{#1}}
\newcolumntype{R}[1]{>{\PreserveBackslash\raggedleft}p{#1}}
\newcolumntype{L}[1]{>{\PreserveBackslash\raggedright}p{#1}}
\makeatletter
\newenvironment{tablehere}
  {\def\@captype{table}}
 {}

\newenvironment{figurehere}
 {\def\@captype{figure}}
 {}
\makeatother%tablehere environment

%Units in header
\def\tabunit#1{\llap{\lower \belowcaptionskip \hbox{#1} \hspace{.03\textwidth}}}

\usepackage{tabularx}

%=================== Enumerates Environment Settings==============================%
%=================================================================================%
\setenumerate{label={\rm \arabic*.},leftmargin=0pt,labelindent=\parindent,labelsep=*,itemindent=1.75\parindent}
\setitemize{leftmargin=0pt,labelindent=\parindent,labelsep=*,itemindent=1.5\parindent}


%====================== Other Predefinitions======================================%
%=================================================================================%
\def\Wd{\hbox{$\mathcal W\kern-.1em\lower.5ex\hbox{$\mathcal D$}$}}
\def\wv{\ensuremath{\scriptsize{\sim}}}
\newcommand{\grad}{\ensuremath{^{\circ}}}%degree
%Roman numbers
\makeatletter
\newcommand{\rmnum}[1]{\romannumeral #1}
\newcommand{\Rmnum}[1]{\expandafter\@slowromancap\romannumeral #1@}
\makeatother

\RequirePackage{lipsum}

\newcommand{\switchgeometry}{
  \newgeometry{left=1in,
             right=2.3346in,
             top=1in,
             bottom=1in,
             headsep=1cm,
             marginparwidth=85pt,
             marginparsep=11pt}

\fancypagestyle{plain}{%
    \fancyhf{} % clear all header and footer fields
    \fancyfootoffset[OR]{\dimexpr\marginparsep+\marginparwidth\relax}
    \fancyfootoffset[EL]{\dimexpr\marginparsep+\marginparwidth\relax}
    \fancyfoot[RO]{\small{\geofont\bfseries\color{black}\thepage}}
    \fancyfoot[LE]{\small{\geofont\bfseries\color{black}\thepage}}
}
}

\newcommand{\wdstartdoc}{
\addtocontents{toc}{\protect\begin{multicols}{2}}
\setcounter{page}{1}
\renewcommand{\thepage}{\arabic{page}}
}

\newcommand{\wdenddoc}{
\addtocontents{toc}{\protect\end{multicols}}
}

\endinput
