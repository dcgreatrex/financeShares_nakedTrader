%----------------------------------------------------------------------------------------------
% Title:                Class: cam-thesis
% Author:            D. Greatrex
% Sub authors:   Jean Martina, Rok Strnisa, Matej Urbas, Krishna Kumar 
% Date:               09/04/2016
% Version:          1.0
% Changes:        -      
%----------------------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
%%
%% General guidelines on which this class is based:
%%
%%     http://www.cl.cam.ac.uk/local/phd/typography/
%%     http://www.admin.cam.ac.uk/offices/gradstud/exams/submission/phd/format.html
%%
%----

%-------------------------------------------------------------------------------
%%
%% Class identification.
%%
%----
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cam-thesis}[2016/10/16 University of Cambridge thesis class]

%-------------------------------------------------------------------------------
%%
%% Package options (see README.md for a list of options with descriptions).
%%
%% These options can be provided within square brackets of the `documentclass'
%% command.
%%
%----

% FONT: times - tells the class to use the times font.
\newif\ifcam@times\cam@timesfalse
\DeclareOption{times}{\cam@timestrue}

% HEADER & FOOTER - page styling request
\newif\ifPHD@pageStyleI\PHD@pageStyleIfalse % Set Page StyleI
\DeclareOption{PageStyleI}{\PHD@pageStyleItrue}

\newif\ifPHD@pageStyleII\PHD@pageStyleIIfalse % Set Page StyleII
\DeclareOption{PageStyleII}{\PHD@pageStyleIItrue}


%-------------------------------------------------------------------------------
%%
%% General Cambridge guidelines.
%%
%% LIMIT: 60k words (including tables and footnotes, excluding appendices, bib,
%% photos, diagrams); title and section headings should be capitalized as normal
%% sentences; citations should include authors' initials, and page numbers (if
%% possible); double-sided printing is permissible for the soft bound version;
%% however, single-sided is required for the text of the final, hard bound
%% library copy (diagrams on facing pages are acceptable); always make it
%% possible to create the ps file as well (required for technical reports).
%%
%----

%-------------------------------------------------------------------------------
%%
%% Using report class as base.
%%
%----
\PassOptionsToClass{a4paper,11pt,oneside,openright}{book}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass{book}

%-------------------------------------------------------------------------------
%%
%% Additional packages, and their options.
%%
%----
% HYPERREFERENCES: Hyperref should be included in any case, but we make it non-obtrusive (i.e.: no hyperlink borders).
% Why do we need a separate treatment of hyperref for the techreport? Because the guidelines say so. :)
\RequirePackage[
    pdffitwindow=true,
    pdfpagelabels=true,
    colorlinks=false,
    pdfborder={0 0 0},
    pdfusetitle=true
]{hyperref}
\RequirePackage[all]{hypcap}        % Fixes links to floats (must be included after hyperref).

% For Print version
\hypersetup{
final=true,
plainpages=false,
pdfstartview=FitV,
pdftoolbar=true,
pdfmenubar=true,
bookmarksopen=true,
bookmarksnumbered=true,
breaklinks=true,
linktocpage,
colorlinks=true,
linkcolor=black,
urlcolor=black,
citecolor=black,
anchorcolor=black
}

% For PDF Online version
%\hypersetup{
%  final=true,
%  plainpages=false,
%  pdfstartview=FitV,
%  pdftoolbar=true,
%  pdfmenubar=true,
%  bookmarksopen=true,
%  bookmarksnumbered=true,
%  breaklinks=true,
%  linktocpage,
%  colorlinks=true,
%  linkcolor=blue,
%  urlcolor=blue,
%  citecolor=blue,
%  anchorcolor=green
%}

\hypersetup{pdfpagelayout=OneColumn}

%-------------------------------------------------------------------------------
%%
%% Define custom environments
%%
%----
\newcommand{\environments}{
%--------------------------------------------
% DEDICATION: The dedication environment makes sure the dedication gets its
% own page, centered
%----
    \newenvironment{dedication}{
    \cleardoublepage
    \onecolumn
    \vspace*{0.2\textheight}
    \thispagestyle{empty}
    \centering
    }
    
    %--------------------------------------------
    % DECLARATION: The declaration environment puts a large, bold, centered
    % "Declaration" label at the top of the page.
    %----
    \newenvironment{declaration}{
    \cleardoublepage
    \chapter*{\centering \Large Declaration}
    \thispagestyle{empty}
    }{
    \flushright
    \@author{}\\
    \@date{}
    \vfill
    }

    %--------------------------------------------
    % ACKNOWLEDGEMENT: The acknowledgements environment puts a large, bold, centered
    % "Acknowledgements" label at the top of the page.
    %----
    \newenvironment{acknowledgements}{
    \cleardoublepage
    \onecolumn
    \chapter*{\centering \Large Acknowledgements}
    \thispagestyle{empty}
    }

    %--------------------------------------------
    % ABSTRACT
    %----
    \newenvironment{abstract}{
    \cleardoublepage
    \onecolumn
    \chapter*{\centering \Large Abstract}
    \thispagestyle{empty}
    }

    %--------------------------------------------
    % Appendices - Set a custom environment and add appendices to toc
    %----
    \RequirePackage[title,titletoc]{appendix}
}


%-------------------------------------------------------------------------------
%%
%% Fonts
%%
%----
% Use the times font if the user selected this option.
\ifcam@times
   \RequirePackage{times}
\fi

% define mathematics fonts
\ifxetex
  % XeLaTeX
  \usepackage{fontspec}
  \usepackage[]{unicode-math}
  \setmainfont[
    Extension = .otf,
    UprightFont = *-regular,
    BoldFont = *-bold,
    ItalicFont = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{xits}
  
  \setmathfont[ 
    Extension = .otf,
    BoldFont = *bold,
  ]{xits-math}
\else
\RequirePackage{mathptmx}  % times roman, including math (where possible)
\fi

% Don't break enumeration (etc.) across pages in an ugly manner
\clubpenalty=10000
\widowpenalty=10000

%-------------------------------------------------------------------------------
%%
%% Define page layout
%%
%----
\RequirePackage{calc}

% Setting the offsets to 'zero' (LaTeX calculates offsets 1in from the left and upper edges of the page) makes the calculation of margins a bit easier.
\setlength{\hoffset}{-1in}
\setlength{\voffset}{-1in}
\newlength{\cam@topmargin}
\newlength{\cam@bottommargin}
          
\DeclareRobustCommand{\cam@calcpaperdims}[4]{%
%
% MARGINS - Taken from Jean Martina, Rok Strnisa, Matej Urbas - Cambridge Computer Lab LaTex Thesis template
%
\setlength{\oddsidemargin}{#1}        % inner margin
\setlength{\evensidemargin}{#2}       % outer margin
\setlength{\cam@topmargin}{#3}        % top margin   
\setlength{\cam@bottommargin}{#4}     % bottom margin  
% Horizontal spacing
\setlength{\textwidth}{\paperwidth-#1-#2}     % text takes the remaining width (210 - inner - outer)
\setlength{\marginparwidth}{\evensidemargin-8mm} % the margin only has 'outer' space available, so we have to make it a bit thinner.
\setlength{\marginparsep}{3mm}
% Vertical spacing
\setlength{\headheight}{5mm}      % The height of the box where the heading text lives
\setlength{\headsep}{5mm}         % The distance between the heading and the top of the text
\setlength{\topmargin}{#3-\headheight-\headsep}
% additional changes
\setlength{\textheight}{\paperheight-#3-1.7\cam@bottommargin}   % text takes the remaining height (297 - top margin - bottom margin)
\setlength{\footskip}{.7\cam@bottommargin} % The distance from the bottom of the text to the bottom of the footer
}
\cam@calcpaperdims{35mm}{30mm}{35mm}{25mm}

%-------------------------------------------------------------------------------
%%
%% Custom header and footer
%%
%----
\RequirePackage{fancyhdr} % Define custom header

% Set Fancy Header Command is defined to Load FancyHdr after Geometry is defined
\newcommand{\setFancyHdr}{

\pagestyle{fancy}
\ifPHD@pageStyleI
% Style 1: Sets Page Number at the Top and Chapter/Section Name on LE/RO
\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1\ }}
\fancyhf{}
\fancyhead[RO]{\nouppercase \rightmark\hspace{0.25em} | 
  \hspace{0.25em} \bfseries{\thepage}}
\fancyhead[LE]{ {\bfseries\thepage} \hspace{0.25em} | 
  \hspace{0.25em} \nouppercase \leftmark}

\else
\ifPHD@pageStyleII
% Style 2: Sets Page Number at the Bottom with Chapter/Section Name on LO/RE
\renewcommand{\chaptermark}[1]{\markboth{##1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
\fancyhf{}
\fancyhead[RO]{\bfseries\nouppercase \rightmark}
\fancyhead[LE]{\bfseries \nouppercase \leftmark}
\fancyfoot[C]{\thepage}

\else
% Default Style: Sets Page Number at the Top (LE/RO) with Chapter/Section Name
% on LO/RE and an empty footer
\renewcommand{\chaptermark}[1]{\markboth {##1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
\fancyhf{}
\fancyhead[LO]{\nouppercase \rightmark}
\fancyhead[LE,RO]{\bfseries\thepage}
\fancyhead[RE]{\nouppercase \leftmark}
\fi

\fi
}

\setFancyHdr % To apply fancy header after geometry package is loaded


%-------------------------------------------------------------------------------
%%
%% Title page
%%
%----




% To do:
% 4 - create a title page the fits the University of Cambridge criteria.
% 5 - sort out the font so that I like the layout
% 6 - try to borrow macros to enable the automatic subsetting of the document.