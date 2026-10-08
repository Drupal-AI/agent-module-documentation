<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Tokens lets site builders define their own reusable tokens — each with a machine name and a block of formatted content — that resolve anywhere Drupal's Token system runs, so `[custom:my_token]` expands to whatever text you stored.

---

The module registers two entity types: **`token_custom`**, a translatable content entity (base table `token_custom`) holding each token's `name`, `machine_name`, `type` (its bundle), `description`, and `content` (a `text_long` value + text format); and **`token_custom_type`**, a config bundle entity that groups tokens into token *types*. A default type, **`custom`**, ships in `config/install`, so out of the box you create tokens under `[custom:<machine_name>]`. It wires into Token via `hook_token_info()` (advertising every type and token) and `hook_tokens()` (replacing a matched `[type:machine_name]` with `getFormattedContent()`, i.e. `check_markup(content, format)`), guarded by a cached allow-list of type ids (`token_custom.allowlist`, rebuilt on the type list cache tag). Tokens and types are managed at **/admin/structure/token-custom** (the `configure` route `entity.token_custom.collection`) with an "Add Token" / "Add Token Type" action; access is gated by the permissions `administer custom tokens`, `administer custom token types`, and `access custom tokens overview`. Because replacements run through a text format, a token can hold rich HTML, and because tokens are ordinary content entities they are translatable and can be created/edited in code via `TokenCustom::create()`. There are no Drush commands and no plugin types.

---

- Define a site-wide `[custom:company_name]` token reused across content and config.
- Store a reusable legal disclaimer as `[custom:disclaimer]` for footers and emails.
- Create a `[custom:support_email]` token so contact details live in one place.
- Provide marketing snippets (promo banners, CTAs) as editable tokens.
- Keep an office address token that editors can update without a deploy.
- Insert reusable rich-text blurbs into node bodies via a text-format-aware token.
- Group related tokens under a new custom token *type* (e.g. `department`).
- Build `[department:manager]`-style tokens for org-chart data.
- Supply tokens consumed by other Token-aware modules (Pathauto, Metatag, Rules).
- Centralize a tagline/slogan so it updates everywhere at once.
- Offer translators a per-language token value using the entity's translation support.
- Store a phone number token used in multiple templates and blocks.
- Create seasonal tokens (e.g. holiday hours) editors swap in and out.
- Hold a reusable social-media handle as a token.
- Define a token for a recurring price or discount value.
- Provide a `[custom:newsletter_signup]` HTML snippet token.
- Let non-developers edit shared content without touching code.
- Seed default tokens via configuration for a distribution/recipe.
- Create tokens programmatically with `TokenCustom::create()` in an update hook.
- Restrict who can manage tokens vs token types via separate permissions.
- Use a custom token inside an email body sent by another module.
- Standardize boilerplate copy across many content types.
- Expose a version/build string as a token for display.
- Maintain a set of reusable call-to-action buttons as formatted tokens.
