# Configuration

Once the module is enabled and `settings.php` points at your Tailwind executable
(see [Installation](../installation/index.md)), the last step is to switch the
compiler on for your theme.

## Activate the compiler in your theme settings

1. Go to **Appearance → Settings** for the theme you want to compile Tailwind for.
2. Find the section **"Tailwind CSS Just-in-time compilation"** and activate the
   compiler.
3. Save.

Now, when you visit your site, the uncompiled CSS input file is dynamically replaced
with a minified Tailwind CSS output that contains only the styles actually used on
that page.

## You do not need a tailwind.config.js

The module automatically feeds the current page's HTML to the compiler as its
`content`, so you do not need to maintain a `tailwind.config.js` with a `content: []`
list. If you need extra custom Tailwind configuration, use Tailwind's `@config`
directive inside your input CSS file. (If you do supply a custom config file, its
`content` key is ignored — the module always sets that itself.)

## Caching

The compiled CSS is cached. For the best performance, keep core's **Internal Page
Cache** module enabled and in use. Where the Internal Page Cache does not apply,
Tailwind JIT can optionally cache the compiled CSS in the database instead.

## BigPipe caveat

Tailwind JIT **cannot** generate styles for blocks rendered by core's **BigPipe**
module. If you use Tailwind JIT, it is recommended to disable BigPipe.

## Good to know

- **Arbitrary values** such as `pt-[1.2345rem]` are supported.
- It works with **Views paging and Ajax** requests.
- It works with **Layout Builder** and **Paragraphs** — classes rendered by Twig
  are detected automatically. Pairing it with a module that injects CSS classes in
  the admin UI (such as Block Class, Layout Builder Styles, or Style Options) lets
  site builders style on the fly.
- It works for **admin themes** too.
- Tailwind is designed around a single CSS input file, so you cannot use a separate
  input file per Drupal library — but you can define a separate input file for Ajax
  requests (for example one without Tailwind's preflight styles).
