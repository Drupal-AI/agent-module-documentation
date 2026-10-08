<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ConvertKit ESP integrates the ConvertKit (now Kit) v3 marketing API so a Drupal site can subscribe visitors to forms/sequences, tag subscribers and expose ConvertKit forms via blocks, fields and a Webform handler.

---

The `ConvertKitAPI` client (in `src/Plugin`) wraps the REST API at `https://api.convertkit.com/` using a Guzzle client, authenticating with an API key (public reads/subscribes) or API secret (account, subscriber lookups, purchases) passed as request parameters. The `Convertkit` service wires config, cache, logger and module handler around it. Configuration lives at `/admin/config/services/convertkit` behind the `administer convertkit configuration` permission; the form recommends storing `client_id`/`client_secret`/`tag_ids` in `settings.php` (`$settings['convertkit_esp']`) rather than config, and can also read them from the database. The module also ships blocks (single and multi form), a field type/widget/formatter, a derivative block plugin and a Webform handler for subscribing form submissions.

Operational notes: the API client instantiates its own `GuzzleHttp\Client` (default TLS verification on) and sends the API key/secret as query or JSON body parameters over HTTPS. Optional debug logging writes to `src/Plugin/logs/debug.log` inside the module directory (references an undefined `Logger` class, so enabling debug will fatal unless a Monolog Logger is imported). Two stale controller files (`AuthenticationCallback.php---`, `CustomFieldsController.php---`) carry a `.php---` suffix, are not loaded by Drupal, and no route references them, so no OAuth callback route is actually active. The info.yml dependency key is misspelled `depencencies`, so `block` is not enforced as a hard dependency.

---
- Enable the module and set the `administer convertkit configuration` permission.
- Visit /admin/config/services/convertkit to enter credentials.
- Prefer storing client_id/client_secret/tag_ids in settings.php.
- Configure the ConvertKit tag(s) applied on subscription.
- Place a ConvertKit form block to embed a signup form.
- Use the multi-form block to offer several forms.
- Add the ConvertKit field to an entity for per-node form selection.
- Attach the Webform handler to subscribe submissions to ConvertKit.
- Subscribe an email to a form via the API client.
- Add a subscriber to a sequence/course.
- Tag a subscriber by tag id.
- Look up a subscriber id by email address.
- Retrieve a subscriber's tags.
- List forms, landing pages, subscription forms and tags.
- Unsubscribe an email from all forms.
- Create or list purchases through the API.
- Enable debug logging to trace API calls (note the Logger caveat).
- Cache form/tag resource lookups to reduce API calls.
