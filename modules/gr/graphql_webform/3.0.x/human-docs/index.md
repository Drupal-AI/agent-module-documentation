# GraphQL Webform — manual setup guide

**GraphQL Webform** (`graphql_webform`) exposes forms built with the **Webform**
module through GraphQL, so a decoupled (headless) front end can render a
Drupal-managed form and post submissions back to it. You keep designing forms in
Drupal with Webform exactly as you always have; a React, Vue, or mobile front
end then asks GraphQL what the form *is* and renders it from the answer.

Forms are the hardest thing to decouple well. A JavaScript app can fetch content
easily, but reproducing a form means recreating every field, its validation, its
conditional logic, its options and its error messages — all of which live in
Webform's configuration and change whenever an editor edits the form. Exposing
the form *definition* over GraphQL avoids that drift: the front end renders from
the definition, so an editor's change reaches it without a redeploy.

The module supports most of Webform's common elements — text and input fields,
dates and times, choices (select, radios, checkboxes, with "other" options),
file and audio uploads, layout groups, and display/action elements. It handles
conditional fields (show, hide, or require based on answers), returns per-field
validation errors, and returns the confirmation message, title, and redirect
after a submission. Closed forms, scheduled open/close dates, and submission
limits — including the "form unavailable" message — are handled too. Two optional
modules add more when installed: **Address** (for the address element) and
**Telephone Validation** (for validating phone numbers).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Webform and GraphQL, and add the optional captcha submodule.

There is **no configuration page** for this module. Forms are configured in
**Webform** as usual, and this module exposes them over GraphQL automatically.

## How to use it

1. Build your forms with **Webform** (**Structure → Webforms**) as you normally
   would — fields, validation, conditional logic, confirmation and access are all
   set there.
2. From your GraphQL client, query a form's definition (its fields, labels,
   options and messages) and render it in the front end.
3. Post the visitor's answers back through the module's submission mutation;
   validation errors come back per field, and the confirmation/redirect comes
   back on success.

## Three things to get right before going live

Because a decoupled client is entirely under the submitter's control, treat the
front end's checks as a convenience only:

- **Server-side validation is the only validation that counts.** Every
  constraint Webform declares must be enforced when the submission arrives.
- **Spam protection is why the captcha submodule exists.** Honeypot and
  time-based tricks that rely on rendering hidden fields don't survive a client
  that renders its own form, so use `graphql_webform_captcha` (see
  [Installation](installation/index.md)) for API-friendly protection.
- **File uploads and multi-step forms** are where these integrations tend to
  fall short — test both against your site's real forms, not just a simple
  contact form.

> **Note:** This 3.x branch is a **beta** (3.0.0-beta1) and requires Webform
> 6.x, GraphQL 5.x, and PHP 8.3.
