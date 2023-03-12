% Version: 2.5.0
\ProvidesClass{homework}[2023/03/12 Class file for homework assignments]
\RequirePackage{expl3, xparse, l3keys2e, ifthen}

\ExplSyntaxOn

\keys_define:nn {homework/option} {
	lang .tl_gset:N = \g__homework_lang_tl,
	newpage .bool_gset:N = \g__newpage_bool,
}
\ProcessKeysOptions{homework/option}

\keys_define:nn {homework/info} {
	name .tl_gset:N = \hwname,
	email .tl_gset:N = \hwemail,
	num .tl_gset:N = \hwnum,
	type .tl_gset:N = \hwtype,
	class .tl_gset:N = \hwclass,
}
\ProvideDocumentCommand \homework {} {\keys_set:nn{homework/info}}

\str_if_eq:onT {\g__homework_lang_tl} {chs} {
	\LoadClass[11pt, fontset=windows]{ctexart}
	\ctexset{section = {format={\Large\bfseries}}}
}
\str_if_eq:onT {\g__homework_lang_tl} {en} {
	\LoadClass[11pt]{article}
}

\RequirePackage[lang=\g__homework_lang_tl]{shortcut}
\RequirePackage{fancyhdr}
\RequirePackage{fullpage}

\pagestyle{fancy}
\setlength{\oddsidemargin}{0in}
\setlength{\evensidemargin}{0in}
\setlength{\topmargin}{0in}
\setlength{\textwidth}{6.5in}
\setlength{\textheight}{8.5in}

\AtBeginDocument {
    % Setup header
    \setlength{\headheight}{15.2pt}
    \setlength{\headsep}{0.2in}
    \lhead{\hwclass}%
    \chead{\hwname\ (\hwemail)}%
    \rhead{\hwtype\ \hwnum}%

    % Setup hrule in header
    \renewcommand{\headrulewidth}{0pt}
    \headrule{}

    % Don't put header on first page
    \thispagestyle{plain}

	\begin{center}
    	{\Large\hwclass\ \hwtype\ \hwnum}
		\par
		\hwname\ (\hwemail)
		\par
		\today
    \end{center}
    \renewcommand{\headrulewidth}{0.4pt}

	\bibliographystyle{plain}
}

% ----- Questions -------------------------------------------------------------
\newcounter{questionCounter}
\newcounter{partCounter}[questionCounter]

% Prefix for questions
\newcommand{\questiontype}[0]{Question}

% Use this if your "written" questions are all under one section
% For example, if the homework handout has Section 5: Written Questions
% and all questions are 5.1, 5.2, 5.3, etc. set this to 5
% Redefine as needed per-question.
% \newcommand{\writtensection}{}

\DeclareDocumentCommand{\question}{o}{%
	% Emit \newpage if option `newpage` is present
	\bool_if:nT{\g__newpage_bool}{%
		\newpage
	}
	% Wrap in minipage so that we don't get a line break enywhere in between
	\noindent\begin{minipage}{\linewidth}%
		\vspace{.2in}%
		\stepcounter{questionCounter}%
		\IfNoValueTF{#1}{
			% Numbered question
			\ifx\writtensection\undefined{}
				\noindent{\bf \questiontype\ \arabic{questionCounter}.}%
			\else
				\noindent{\bf \questiontype\ \writtensection.\arabic{questionCounter}}%
			\fi
		}{
			% Named question, takes one argument
			\noindent{\bf \arabic{questionCounter}. #1}%
		}
		\vspace{0.3em} \hrule \vspace{.1in}%
	\end{minipage}
	\par
}

% ----- Question Parts --------------------------------------------------------

\newenvironment{alphaparts}[0]{%
  \begin{enumerate}[label=\textbf{(\alph{partCounter})}]%
}{\end{enumerate}}

\newenvironment{arabicparts}[0]{%
  \begin{enumerate}[label=\textbf{\arabic{questionCounter}.\arabic{partCounter}})]%
}{\end{enumerate}}

\newcommand{\questionpart}[0]{\stepcounter{partCounter}\item}

\renewenvironment{answer}{\noindent{\bf Answer:}}{\par}

\ExplSyntaxOff