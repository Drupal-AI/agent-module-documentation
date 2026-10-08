# Handlebars — manual setup guide

**Handlebars** (`handlebars`) integrates the
[Handlebars.js](https://handlebarsjs.com/) client-side templating library with
Drupal. It's aimed at back-end developers who are comfortable with Twig and want
to render HTML in the browser from JavaScript — without taking on the overhead of
React or another framework that needs a build/compilation step.

The core idea is that you define your Handlebars templates as **Drupal
libraries**, and the module makes them available to a JavaScript renderer on the
page. You keep the same markup and CSS as the rest of your Drupal site, but render
pieces of it dynamically from data — a REST endpoint, a JSON/XML feed, anything
your JavaScript can fetch. It's a good fit for lightly decoupled features like a
menu rendered from the REST API or a product list rendered from a store feed.

Enabling the module doesn't do anything visible on its own — nothing happens until
*you* define templates and call the renderer from your own JavaScript. This is a
developer tool, so setup lives in your module/theme code rather than in the admin
UI; the "How to use it" section below walks through the shape of it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You use it by defining
templates in code (as Drupal libraries) and calling the renderer from JavaScript,
described next.

## How to use it (Drupal 10/11)

1. **Define each template as a Drupal library.** In your module's
   `*.libraries.yml`, declare a library whose **name matches the template
   filename**, mark it as a Handlebars template with `type: handlebars_template`,
   and point it at your `.handlebars` file:

   ```yaml
   # This key must match the .handlebars template filename.
   article.block.demo:
     version: 1.x
     type: handlebars_template
     js:
       templates/article.block.demo.handlebars: {}
   ```

2. **Write the template** in Handlebars syntax
   (`templates/article.block.demo.handlebars`):

   ```handlebars
   Here is the content of foo: {{ foo }}
   ```

3. **Render it from JavaScript**, passing the template name and a data object
   (the data can come from a REST endpoint):

   ```javascript
   let data = { foo: 'bar' };
   var html = handlebarsRenderer.render('article.block.demo', data);
   document.getElementById('container').innerHTML = html;
   ```

Because the template markup mirrors your Twig/HTML, your existing styling works
out of the box. See the [Handlebars.js guide](https://handlebarsjs.com/guide/)
for template syntax and partials, and the module's own `README.md` for more.
