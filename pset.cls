% HMC Math HW class file
% v0.04 by Eric J. Malm, 10 Mar 2005
% Modified Kip Lim, 05 Sept 2019

%%% IDENTIFICATION --------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}[1995/01/01]
\ProvidesClass{pset}
    [2019/09/05 HMC Problem Set Class]

%%% INITIAL CODE ----------------------------------------------------------

% test whether the document is being compiled with PDFTeX
\RequirePackage{ifpdf}


%%% DECLARATION OF OPTIONS ------------------------------------------------
%% Header Options: header*, no header
\newif\ifpset@header

% no header block in upper right hand corner
\DeclareOption{noheader}{%
    \pset@headerfalse%
}

% do print header block
\DeclareOption{header}{%
    \pset@headertrue%
}

%% Font Options: palatino*, cm
\newif\ifpset@palatino

% use palatino fonts
\DeclareOption{palatino}{%
    \pset@palatinotrue%
}

% use compuer modern fonts
\DeclareOption{cm}{%
    \pset@palatinofalse%
}

%% Problem Boxing: boxed*, unboxed
\newif\ifpset@boxed

% box problem statements
\DeclareOption{boxed}{%
    \pset@boxedtrue%
}
   
% don't box problem statements
\DeclareOption{unboxed}{%
    \pset@boxedfalse%
}
   
% pass remaining options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
% including header, 
% loading mathpazo package for palatino fonts,
% boxing problem statements
\ExecuteOptions{header,palatino,boxed}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std article class
\LoadClass{article}


%% Font loading: Palatino text/math fonts
\ifpset@palatino
    \RequirePackage{mathpazo}
\fi

%% AMSLaTeX math environments and symbols
\RequirePackage{amsmath}
\RequirePackage{amssymb}

%% boxed minipage for boxed problem environment
\RequirePackage{boxedminipage}

%%% MAIN CODE -------------------------------------------------------------
%% Tell dvips/pdflatex correct page size
\ifpdf
  \AtBeginDocument{%
    \setlength{\pdfpageheight}{\paperheight}%
    \setlength{\pdfpagewidth}{\paperwidth}%
  }
\else
  \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
\fi


%% Problem set environments
% boxed problem environment
\newenvironment{problem}[1][]{%
  \ifpset@boxed\def\pset@probenv{boxed}\else\def\pset@probenv{}\fi%
  \smallskip% put space before problem statement box %
  \noindent\begin{\pset@probenv minipage}{\columnwidth}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty\else%
    \pset@probformat{#1}\hspace{0.5em}%
  \fi%
}{%
  \end{\pset@probenv minipage}%
}
% display optional argument to problem in bold
\let\pset@probformat\textbf

% solution environment with endmark and optional argument
\newenvironment{solution}[1][]{%
  \begin{trivlist}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty%
    \item[]%
  \else%
    \item[\hskip\labelsep\relax #1]%
  \fi%
}{%
  \mbox{}\penalty10000\hfill\pset@endmark%
  \end{trivlist}%
}

% default endmark is small black square
\def\pset@endmark{\ensuremath{\scriptscriptstyle\blacksquare}}

%% Problem set list, for top of document
\newcommand{\problemlist}[1]{\begin{center}\large\sffamily{#1}\end{center}}

%% commands for upper-right id header block
\newcommand{\headerblock}{%
\begin{flushright}
\begin{small}
\mbox{\pset@name}\protect\\
\mbox{\pset@class}\protect\\
\mbox{\pset@assignment}\protect\\
\pset@duedate%
\ifx\pset@extraline\empty\else\protect\\\pset@extraline\fi%
\end{small}
\end{flushright}%
}

% put id header block at start of document
\ifpset@header\AtBeginDocument{\headerblock}\fi

% internal state for headerblock
\def\pset@name{}
\def\pset@class{}
\def\pset@assignment{}
\def\pset@duedate{}
\def\pset@extraline{}

% commands to set header block info
\newcommand{\name}[1]{\def\pset@name{#1}}
\newcommand{\class}[1]{\def\pset@class{#1}}
\newcommand{\assignment}[1]{\def\pset@assignment{#1}}
\newcommand{\duedate}[1]{\def\pset@duedate{#1}}
\newcommand{\extraline}[1]{\def\pset@extraline{#1}}

    
% commands to add blank pages
    \usepackage{afterpage}
    \newcommand{\blankpage}[1]
    {
        \null
        \thispagestyle{empty}
        \addtocounter{page}{-1}
        \newpage
    }

% set numbering style for enumerated lists to be of form (a), (b), (c), etc.
    \renewcommand{\labelenumi}{{\bf (\alph{enumi})}}
    
%for drawing graphs
    \usepackage{tikz}
    \usepackage{amsmath}
    \makeatletter
    \renewcommand*\env@matrix[1][*\c@MaxMatrixCols c]{%
      \hskip -\arraycolsep 
      \let\@ifnextchar\new@ifnextchar
      \array{#1}}
    \makeatother

% extra packages
    \usepackage{amsfonts, amsmath, amssymb, amsthm, enumerate, esvect, fancyhdr, gensymb, graphicx, lastpage, mathtools, mathrsfs, multicol, parskip}
    
% creates vectors and real number symbols
    \renewcommand{\v}[1]{\textbf{#1}}
    \newcommand{\R}{\mathbb{R}}
    \newcommand{\Rn}[1]{\mathbb{R}^#1}
  
% creates multiset notation  
\def\multiset#1#2{\ensuremath{\left(\kern-.3em\left(\genfrac{}{}{0pt}{}{#1}{#2}\right)\kern-.3em\right)}}

% defines some theorem/proof styles
    \theoremstyle{definition}
    \newtheorem{definition}{Definition}[section]
     
    \theoremstyle{remark}
    \newtheorem*{remark}{Statement}
    
    \renewcommand\qedsymbol{\ensuremath{\scriptscriptstyle\blacksquare}}