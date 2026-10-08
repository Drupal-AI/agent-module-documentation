# Configuration

This module has **no settings page of its own**. All of its configuration is a
small JSON payload you attach to each **cookie category** — the module simply adds
a **GTM data** field to the cookie‑category forms you already use.

## Where you configure it

1. Log in as a user who can administer EU Cookie Compliance.
2. Go to **Configuration → System → EU Cookie Compliance → Categories**
   (`/admin/config/system/eu-cookie-compliance/categories`).
3. Add or edit a cookie category (for example *Analytics*, *Marketing*,
   *Functional*). Each add/edit form now includes a **GTM data** field.

## The GTM data field

The **GTM data** field takes a **JSON object** — a set of `"key": "value"` pairs
wrapped in `{ }`. The keys become entries pushed to the GTM `dataLayer`, and the
values can be literal text or one of the status tokens described below. The field
is validated: invalid JSON, or JSON that isn't an object, is rejected. Leaving the
field empty removes the GTM data from that category entirely.

### Status tokens

Inside the JSON values you can use two placeholders that are replaced with live
consent state at run time:

- **`@status`** — replaced with `1` if **this** category is currently accepted, or
  `0` if it isn't.
- **`@<machine_name>_status`** — replaced with the accepted state (`1`/`0`) of
  **another** category, identified by its machine name. For example
  `@functional_status` reflects whether the *functional* category is accepted.

### Examples

On the **Analytics** category, push a single flag that mirrors this category's
consent:

```json
{"analytics": "@status"}
```

On a category that wants to report both its own and another category's state:

```json
{"analytics": "@status", "functional": "@functional_status"}
```

With these in place, GTM triggers can watch the `analytics` (and `functional`)
`dataLayer` values and only fire the relevant tags when consent is `1`.

## How the values reach Google Tag Manager

You don't need to wire anything up in the theme or the GTM container by hand. Once
saved, the front‑end script this module attaches to every page:

1. Listens for the consent events fired by the main EU Cookie Compliance module.
2. On a consent change, reads each category's GTM data.
3. Substitutes the `@status` / `@<machine_name>_status` tokens with the current
   `1`/`0` values.
4. Pushes the resulting object to GTM's `dataLayer`.

So the moment a visitor accepts or changes their cookie preferences, the updated
consent flags are available to your GTM triggers — including when they revisit and
change their mind later.

## Save

Save the cookie category as usual. Because the GTM data is stored on the cookie
category (as exportable configuration), it moves between environments with your
normal config export/import, keeping your consent‑to‑GTM mapping in version
control alongside the rest of your site config.
