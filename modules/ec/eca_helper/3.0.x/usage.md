ECA Helper adds a large catalogue of extra ECA (Event-Condition-Action) actions and a few extra events to the [ECA](https://www.drupal.org/project/eca) no-code automation module, covering HTTP requests, form/preprocess/render manipulation, response headers and cookies, file I/O, JSON, key-value storage and more.

---

The module ships ~30 ECA action plugins (all prefixed `eca_helper_*`) plus three custom ECA events, letting site builders wire behaviour in the ECA modeller without writing a custom module. Actions include an outbound HTTP request client, get/set of `$_SERVER`/`$_COOKIE`/`$_SESSION`/`$_GET`/`$_POST` values, setting/removing response headers, appending `<script>`/`<style>`/markup to page head/top/bottom, setting response cookies, reading and writing files, JSON encode/decode, key-value store writes, third-party-setting get/set, current-route lookup, and reading/altering the render/preprocess variables and form arrays. A "Quick Action" plugin lets a developer register ad-hoc callables in `DRUPAL_ROOT/sites/eca/EcaActions.php` (an `ECAQuickActions()` function returning id → label/callback/service) and invoke them from a model without defining a plugin. The custom events are `eca_helper` (Status Messages, fired when Drupal status messages are rendered so a model can read/alter them), `eca_helper_file_download` (private file download — a model returns an access result that maps onto `hook_file_download()`), and `eca_helper_preprocess_hook` (fires on every `hook_preprocess` so a model can alter template variables). It also decorates the core `messenger` service to dispatch the Status Messages event. Everything is configured by administrators inside ECA models; there is no dedicated settings form (`configure` is null) and no permissions of its own — access is governed by ECA's own permissions. The optional `eca_helper_workflow` submodule adds Content Moderation workflow-state actions.

---

- Fire an outbound HTTP request (GET/POST, headers, body, cookies) as a step in an ECA model and capture the response into a token.
- Read a `$_SERVER`, `$_COOKIE`, `$_SESSION`, `$_ENV`, `$_GET` or `$_POST` value into an ECA token.
- Set or remove an HTTP response header from a model (e.g. add a custom security or cache header).
- Set a response cookie from an ECA model.
- Inject a `<script>`, `<style>` or raw markup tag into the page head, top or bottom.
- Attach a Drupal library to the page from a preprocess/render step.
- Read the value of a form element by key inside a form event.
- Set the value of a form element by key inside a form event.
- Dump a form array (or arbitrary data) for debugging while building a model.
- Add a CSS class to a form element.
- Get or set render/preprocess template variables by key.
- Add a CSS class to a preprocess variable's attributes.
- Remove an item from a preprocess variables array.
- Encode data to JSON or decode a JSON string within a model.
- Write a value into Drupal's key/value store.
- Get or set an entity's third-party settings.
- Convert a formatted date string to a Unix timestamp.
- Look up the current route name/parameters from a model.
- Check whether a file exists, read a file's contents, or write contents to a file.
- Create a File entity from a path/URI.
- React to Drupal status messages being rendered and read or rewrite them.
- Grant or deny access to a private file download by returning an access result from a model.
- Alter any template's variables by responding to the generic preprocess event.
- Register a one-off custom callable in `sites/eca/EcaActions.php` and call it via the Quick Action plugin without writing a plugin class.
- Read or set the Content Moderation workflow state of an entity (via the `eca_helper_workflow` submodule).
