# Configuration

Symfony Mailer Addons has two independent parts to configure: the **Email Footer
Links** form, and the two **adjuster plugins** you attach to a Symfony Mailer
policy.

## Email footer links

1. Log in as a user with the **administer mail footer links** permission.
2. Go to **Configuration → System → Mailer → Email footer links**, or navigate
   directly to `/admin/config/system/mailer/email-footer-links`. (It appears as
   a local task alongside Symfony Mailer's policy configuration.)
3. Add one or more links **for each enabled language**. Because the links are
   defined per language, each site language can carry its own translated set —
   useful for localised legal, unsubscribe, or marketing links.
4. Save the form.

To render the links, output the **`footer_links`** variable in your email Twig
templates. Whatever you defined for the active interface language is what appears
in that email's footer, so footer content stays consistent across all the
transactional email Symfony Mailer sends.

## Email adjusters (on a Symfony Mailer policy)

The module also provides two adjuster plugins. Adjusters are not configured on
their own page — you attach them to a **Symfony Mailer policy** and then set
their options there.

1. Open the Symfony Mailer policy configuration and edit (or create) the policy
   you want to affect.
2. Add one of the module's adjusters to the policy:
   - **Email Template Suggestion Adjuster** — registers extra Twig template
     suggestions so you can theme specific emails with your own templates.
   - **Legacy Body Format Email Adjuster** — normalises legacy body formats so
     that HTML emails (for example those coming from migrated or older policies)
     render correctly.
3. Configure the adjuster's settings on the policy as needed, then save.

You can add either adjuster, both, or neither, depending on what a given policy
needs.
