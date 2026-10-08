<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Newsletter Subscribe webform handler

`src/Plugin/WebformHandler/WebnewsletterSubscribeWebformHandler.php` — a Webform handler plugin that
turns a webform submission into a `webnewsletter_emails` subscriber entity.

## Plugin definition

`@WebformHandler`:
- `id = "webnewsletter_subscribe"`, `label = "Newsletter Subscribe"`, `category = "Web Newsletter"`.
- `cardinality = CARDINALITY_UNLIMITED`, `results = RESULTS_PROCESSED`, `submission = SUBMISSION_REQUIRED`.

Extends `WebformHandlerBase`. `create()` injects `current_user`.

## Behaviour (`postSave()`)

Runs after a submission is saved:

1. Returns immediately when `$update` is TRUE (only acts on the first save / new submission).
2. Reads submission data: `email = $data['email'] ?? ''`, `name = $data['name'] ?? ''`.
3. Returns if `email` is empty.
4. Loads the `webnewsletter_emails` storage and calls `loadByProperties(['email' => $email])`;
   if a record with that email already exists it returns (**de-dupe by email** — no duplicate subscriber).
5. Otherwise `create()`s + `save()`s a new subscriber with `email`, `name`, `status = TRUE`, and
   `uid = current_user->id()` (anonymous submitters → uid forced to 0 in the entity's `preSave()`).

`buildConfigurationForm()` / `submitConfigurationForm()` are no-ops — the handler has no settings.

## Attaching it

To capture subscribers from any webform, add the "Newsletter Subscribe" handler to that webform and
give the form `email` and `name` elements (the handler keys on those data names). The default recipe
already attaches it (see below).

## The default subscribe form (recipe)

`recipes/default/config/webform.webform.newsletter_subscribe.yml` ships webform `newsletter_subscribe`:

- Elements: `name` (textfield, required), `email` (email, required), a hidden `subscription` checkbox
  (`#access: false`), and a Subscribe submit button.
- `settings.page = true`, `page_submit_path: /newsletter/subscribe` — a standalone public page.
- `access.create.roles: [anonymous, authenticated]` — the subscribe form is intentionally open to
  everyone; only the management UI ([../api/emails-entity.md](../api/emails-entity.md)) is permission-gated.
- Two handlers: `webnewsletter_subscribe` (this plugin, stores the subscriber) and `email_confirmation`
  (core Webform email handler) which sends the submitter a "You've subscribed to our newsletter" /
  "Thank you for subscribing" message on completion.

So the end-to-end flow is: visitor submits `/newsletter/subscribe` → Webform saves the submission →
`webnewsletter_subscribe` handler stores/de-dupes a `webnewsletter_emails` entity → `email_confirmation`
handler emails the submitter → staff see the record in the admin list.
