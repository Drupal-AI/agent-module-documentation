# REST Consumer — manual setup guide

**REST Consumer** (`restconsumer`) is a small developer helper that provides a
consistent JavaScript API for making REST calls from the browser — a thin, unified
wrapper over `jQuery.ajax` and `Drupal.ajax`. It gives front-end code a single,
predictable interface for GET/POST-style requests, with built-in multilingual
support (it can prefix your endpoints with a language code) and some helpers for
forms and uploads. On its own it does nothing useful: it is meant to be **used by
other modules' JavaScript**, which depend on one of its libraries and then call the
wrapper.

There are two ways to pull it in from your module's library definition:

- **`restconsumer/simple`** loads a `Restconsumer_Wrapper` class into the global
  JavaScript namespace, which you instantiate yourself:

  ```javascript
  var consumer = new Restconsumer_Wrapper();
  consumer.setLang('fr');          // optional: prefix endpoints with a language
  consumer.authorized = true;      // optional: skip token authorization
  consumer.get('/this/is/my/endpoint').done(function (data) {
    // do something with data
  });
  ```

- **`restconsumer/restconsumer`** initialises a fully loaded, authorized,
  multilingual instance and attaches it to Drupal's JavaScript object as
  `Drupal.restconsumer` — the usual way to consume Drupal's own REST resources:

  ```javascript
  Drupal.restconsumer.get('/this/is/my/endpoint').done(function (data) {
    // do something with data
  });
  ```

Note the security-relevant point that comes with any HTTP client: REST Consumer
issues requests, and in the `restconsumer/restconsumer` setup those calls carry the
current user's authorization. If any request URL is ever built from user-controlled
input, that is a request-forgery surface — keep endpoint URLs static or
admin-defined and allow-list destinations where they must be dynamic. When it is used
to reach *external* APIs, keep any API credentials out of plain configuration and
ensure requests use TLS with certificate verification (never disable cert checks).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module so its libraries are available to your code.

There is **no configuration page** for this module — it is a JavaScript library you
build on in code, not a form you fill in. It becomes useful only when another module
depends on one of its libraries and calls the wrapper.

## Where it lives in the admin menu

REST Consumer adds no admin page and no settings form. Its entire surface is the
JavaScript libraries it provides; you consume them from your own module's code.
