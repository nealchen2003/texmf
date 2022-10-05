% Version: 2.4.0
\ProvidesClass{homework}[2022/09/21 Class file for homework assignments]
\RequirePackage{expl3, xparse, l3keys2e, ifthen}

\ExplSyntaxOn

\keys_define:nn {homework/option} {
	lang .tl_gset:N = \g__homework_lang_tl
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
	\LoadClass[11pt]{ctexart}
	\ctexset{section = {format={\Large\bfseries}}}
}
\str_if_eq:onT {\g__homework_lang_tl} {en} {
	\LoadClass[11pt]{article}
}

\RequirePackageWithOptions{shortcut}
\RequirePackage{fancyhdr, fullpage}

\pagestyle{empty}
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

\ExplSyntaxOff