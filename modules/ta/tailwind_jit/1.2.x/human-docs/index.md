# Tailwind JIT — manual setup guide

**Tailwind JIT** (`tailwind_jit`) brings **Just-in-Time compilation of Tailwind
CSS** to Drupal themes. Rather than shipping the entire Tailwind framework or
running a separate Node build every time you change a template, this module
generates — on the fly, per page — only the Tailwind utility classes that page
actually uses. The result is a perfectly minimized stylesheet for every single page
of your site, with no manual build step in your day-to-day workflow.

The way it works: you write Tailwind utility classes in your Twig templates as
normal, and when a visitor loads a page, Tailwind JIT hands the page's HTML to the
Tailwind compiler and swaps your uncompiled input CSS for a minified output
containing just the classes in use. It works with arbitrary values (like
`pt-[1.2345rem]`), with Views paging and Ajax, and with Layout Builder and
Paragraphs, since classes rendered by Twig are detected automatically.

Tailwind JIT is a **theming / front-end developer tool**. It operates purely on CSS
generation and has no content or access-control behaviour. It requires no other
Drupal modules, but it does need a **Tailwind CSS executable** available on your
server and a small amount of setup — a path in `settings.php` and switching the
compiler on in your theme's settings — so it does *not* work purely on enable.

Two things worth knowing up front: the module **cannot** generate styles for blocks
rendered by core's **BigPipe** module (disabling BigPipe is recommended if you use
Tailwind JIT), and the compiled CSS is cached — for best performance keep core's
*Internal Page Cache* enabled, though Tailwind JIT can also cache compiled CSS in
the database itself.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Tailwind CSS
   executable, and point `settings.php` at it.
2. [Configuration](configuration/index.md) — activate the compiler in your theme
   settings, plus caching and BigPipe notes.
