# Configuration

There's nothing you *have* to configure — by default the module exposes **every**
image style you've defined. The single settings form only exists so you can narrow
that down to an allow-list, which is worth doing if you have many styles but your
front end only needs a few (smaller API payloads, less clutter).

## Open the settings form

1. Log in as a user with the **Administer image styles** permission (the module
   reuses this core permission rather than defining its own).
2. Go to **Configuration → Web Services → JSON:API Image Styles**, or navigate
   directly to `/admin/config/services/jsonapi/image_styles`.

## Choosing which styles to expose

The form shows a checkbox for every image style on your site. The rule is simple:

- **Leave everything unchecked** (the default) — *all* image styles are exposed on
  the API. This is also what happens before you've ever saved the form.
- **Check one or more styles** — only the checked styles are exposed; everything
  else is hidden from the `image_style_uri` field.

So to publish only `thumbnail` and `large`, tick just those two and save. To go
back to exposing everything, uncheck them all and save again.

Click **Save configuration** to apply. The module tags JSON:API responses with a
cache tag tied to this setting, so the change takes effect on fresh requests
automatically — no manual cache rebuild required (though one never hurts).

## Reading or setting it from the command line

```bash
drush cget jsonapi_image_styles.settings image_styles
```

The stored value is a map where a selected style has a truthy value (its own name)
and an unselected one is `0`. If the filtered result is empty, the "expose
everything" fallback applies.
