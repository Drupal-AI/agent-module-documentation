# Configuration — enabling and tuning the banner

The **Settings** page is where you turn the consent banner on, decide who sees it,
and choose the consent model that matches your legal requirements. Take a moment
to understand the consent methods before you go live — the choice you make here is
what determines whether your site is actually asking for consent the way GDPR
expects.

## Open the Settings page

1. Go to **Configuration → System → EU Cookie Compliance → Settings**
   (`/admin/config/system/eu-cookie-compliance/settings`).
2. Make sure you are on the **Settings** tab (the first of the three tabs:
   **Settings**, **Categories**, and **Translate eu cookie compliance**).

![The EU Cookie Compliance Settings page](../images/settings.png)

## Enable the banner

At the very top of the form is the **Enable banner** checkbox. Tick it to switch
the consent banner on for the whole site; clear it to switch the banner off without
uninstalling the module. Nothing below this checkbox has any effect until the
banner is enabled.

## Choose who sees the banner

The **Permissions** section controls which visitors the banner is shown to. Under
**Display the banner for**, tick the roles that should be asked for consent:

- **Anonymous user** — visitors who are not logged in. This is the group that most
  often needs the banner.
- **Authenticated user** — any logged-in visitor.
- **Content editor** — an example content-authoring role.

Tick every role that must be shown the consent popup and clear the ones that
should never see it.

## Choose a consent method

The **Consent for processing of personal information** section is the heart of the
form. It explains that the EU General Data Protection Regulation (GDPR) requires
consent to be **unambiguous** and to involve a **clear affirmative action**, then
offers a **Consent method** — a set of radio buttons that decide *how* the banner
asks for and records consent. Only one can be selected. Here is what each one
means:

### Consent by default. Don't provide any option to opt out.

The banner is purely informational — it tells visitors the site uses cookies but
gives them no way to refuse. Consent is assumed. This is the lightest option, but
because it offers no affirmative choice it does **not** meet the GDPR standard of
unambiguous, opt-in consent. Use it only where a simple cookie notice is all you
need.

### Opt-in. Don't track visitors unless they specifically give consent. (GDPR compliant)

Nothing that requires consent runs until the visitor actively agrees. This is the
strict opt-in model GDPR expects: no non-essential cookies or tracking until the
visitor clicks to accept. It is the safe default for most EU-facing sites.

### Opt-in with categories. Let visitors choose which cookie categories they want to opt-in for. (GDPR compliant)

A more granular version of opt-in. Instead of a single accept/decline choice, the
banner presents named **cookie categories** (for example functional, analytics,
marketing) and lets the visitor opt in to each one separately. You define these
categories on the **Categories** tab (see below). This is the option to choose when
different kinds of cookies need separate consent — for example allowing analytics
but not marketing.

### Opt-out. Track visitors by default, unless they choose to opt out.

The opposite of opt-in: tracking is on from the first page view, and the banner
gives visitors a way to turn it off. Because consent is assumed rather than freely
given up front, this model is generally **not** considered GDPR-compliant for the
EU, though it may suit sites operating under other regimes.

### Automatic. Respect the DNT (Do not track) setting in the browser, if present.

The module reads the visitor's browser **Do Not Track (DNT)** signal and adapts:
it behaves like **opt-in** when DNT is 1 (the visitor has asked not to be tracked)
or when DNT is not set, and like **consent by default** when DNT is 0 (the visitor
has explicitly allowed tracking). This defers to whatever preference the visitor
has already expressed in their browser.

## Disable scripts until consent is given

Below the consent method is the **Disable the following JavaScripts when consent
isn't given** section, with a **Disable JavaScripts** text area. List the scripts
that should be held back until the visitor consents — for example analytics or
marketing tags — and the module will keep them from running until the matching
consent is recorded. This is what makes the banner actually *block* tracking rather
than merely announce it, and it pairs naturally with the **Opt-in with categories**
method so each script only loads once its category is accepted.

## The banner message and appearance

The rest of the settings form (further down the page) lets you customise the banner
itself — its message text, button labels, and where it appears on the page. Adjust
those to match your site's wording and design, then review the result on the front
end.

## The Categories tab

If you chose **Opt-in with categories**, switch to the **Categories** tab to define
the cookie categories visitors will choose from. Each category has a label and
description shown in the banner, so name them clearly (for example "Analytics" or
"Marketing"). Managing categories requires the *administer eu cookie compliance
categories* permission.

## Save

Click **Save configuration** at the bottom of the form. The banner takes effect
immediately for the roles and consent method you selected — visit the site as an
anonymous visitor to confirm it appears and behaves the way you expect.
