*lotus.vim*         Make Vim suck less Lotus projects

Author: Arjan van der Gaag <http://arjanvandergaag.nl>
License: Same terms as Vim itself (see |license|)

This plugin is only available if 'compatible' is not set.

=============================================================================
INTRODUCTION                                     *lotus* 

This plugin helps you navigate and develop projects using the Lotus web
framework. A Lotus project is detected by searching a .lotusrc file up the
directory hierarchy. When you edit a file in a Lotus project, this plugin will
be activated. This sets various options and defines some commands. It also
integrates with other Vim plugins.


=============================================================================
NAVIGATION                                       *lotus-navigation*

Navigating a Lotus project's many files is what this project is mostly about.
You should first and foremost try to use Vim's own navigation features to get
around your project. To that end, this plugin will tweak a few settings.

First, all common Lotus code locations are prepended to 'path', enabling you
to use |:find|:
>
	:find new.rb
<
Second, 'suffixesadd' has common Lotus file extensions prependend to it,
allowing you to use |:find| and |gf| to jump to files.

=============================================================================
COMMANDS                                         *lotus-commands*

:Lotus [subcommand]	Invoke the lotus CLI with the given subcommand.

=============================================================================
INTEGRATIONS                                     *lotus-integrations*

                                                 *lotus-projections*
The |projections| plugin can be used to define navigation commands. This
plugin provides several projections based on Lotus project layout conventions.

This plugin provides projections for entities, repositories, migations and
files in {./lib}. These work like you may expect from regular projections:

:Eentity [entity]		Edit a file in {./lib/bookshelf/entities}

:Erepository [repository]	Edit a file in {./lib/bookshelf/repositories}

:Elib [filename]		Edit a file in {./lib}

:Emigration [filename]		Edit a file in {./db/migrations}, or
				{db/schema.sql} if there is no {filename} given.

There are also projections for application-specific files. These are available
per application. By default, Lotus apps are generated with a `web`
application. For that application, you can use these projections:

:EwebController [controller]	Edit a file in {./apps/web/controllers}

:EwebView [view]		Edit a file in {./apps/web/views}

:EwebTemplate [template]	Edit a file in {./apps/web/templates}

:EwebConfig [filename]		Edit a file in {./apps/web/config}, or,
				without any arguments,
				{./apps/web/application.rb}.

If you have more than one application (that is, subdirectories in {./apps}),
then each of these projections have a variant that includes the application
name.

                                                 *lotus-snippets*
The |UltiSnips| plugin can help you to quickly inserts commonly used snippets
of code. This plugin adds several Lotus-related snippets, that will
automatically become available in Lotus projects.

See {ultisnips/ruby.snippets} to see what's available.

                                                 *lotus-surround*
The |surround| plugin allows adding and removing "surrounding" characters,
such as parantheses, quotes and HTML tags. This plugin provides a few helpful
additional surroundings:

Key	Surrounding ~
=	<%= ^ %>
-	<% ^ %>
#	<%# ^ %>
<C-E>	<% ^ -%>\n<% end -%>

=============================================================================
ABOUT                                            *lotus-about*

To find our more about the Lotus framework, see:

https://github.com/lotus/lotus

To get the latest updates or report bugs, see this plugin's Github repository:

https://github.com/avdgaag/vim-lotus

 vim:tw=78:ts=8:ft=help:norl:
