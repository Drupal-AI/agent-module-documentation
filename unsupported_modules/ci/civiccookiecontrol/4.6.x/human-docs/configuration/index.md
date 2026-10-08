# Configuration

Configuration happens on the module's admin screens. Because the consent engine is
Civic's hosted product, the essential first step is supplying your Civic
credentials; the rest is describing your cookies so the banner can present the
right choices.

## Open the configuration screens

Log in as a user with the **Administer civiccookiecontrol** permission and follow
the module's *configure* link (the *Cookie Control admin overview*,
`cookiecontrol.admin_overview`). This permission is separate from general site
administration, so you can grant cookie‑consent configuration to a compliance
officer without giving them broader rights:

```bash
drush role:perm:add compliance_officer 'administer civiccookiecontrol'
```

## Add your Civic API key

The banner is Civic's hosted widget, so it needs the **API key / licence** from
your Civic Cookie Control account. Enter it on the main settings screen — without
it the banner won't run. This screen is also where you set the banner's general
appearance and behaviour options exposed by Civic.

Behind the scenes the module keeps three configuration objects — the main settings
(`civiccookiecontrol.settings`) plus two vendor lists for the IAB frameworks
(`civiccookiecontrol.iab`, `civiccookiecontrol.iab2`) — but you edit them through
the admin screens rather than by hand.

## Define cookie categories

Set up the **cookie categories** visitors will see — typically groups like
*Analytics*, *Marketing* and *Functional*. Each category gets its own description
shown to visitors, and each can be accepted or rejected independently. Align these
with your privacy policy so the banner and your documentation agree.

Categories are where blocking actually happens: a script you want held back until
consent must be **wired to its category**. Enabling the module alone shows the
banner but does not stop scripts other modules add unconditionally.

## Declare strictly necessary cookies

Some cookies are essential and can't be rejected. Declare these as **necessary
cookies** so the widget lists them as always‑on and doesn't offer visitors a
toggle to switch them off.

## Configure IAB TCF vendors (if you run programmatic ads)

If your site serves programmatic advertising, configure the **IAB Transparency &
Consent Framework** vendor lists — the module supports both the TCF and TCF v2
vendor configuration. Keep these updated as your ad‑tech partners change. If you
don't run programmatic advertising, you can leave these alone.

## Add consent text in other languages

For a multilingual site, provide **alternative‑language consent text** so the
banner's wording appears in each language you serve.

## After configuring

- **Export your settings** with the rest of your site configuration so the setup
  is repeatable across environments.
- Because the widget loads a **third‑party hosted asset**, check it against your
  site's Content Security Policy and your own data‑processing documentation.
- Re‑verify that the scripts you intended to gate are actually attached to the
  right categories — that's the part that turns the banner from cosmetic into
  compliant.
