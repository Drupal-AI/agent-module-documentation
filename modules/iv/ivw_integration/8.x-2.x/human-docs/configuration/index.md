# Configuration

Configuring IVW Tracking is about two things: entering the **IVW/SZM identifiers**
your measurement provider gave you, and — just as important — making sure the
tracking is only active in a way that respects **consent** and privacy law.

## Grant the administer permission

IVW Tracking provides its own permission for administering the tracking. Grant it
under **People → Permissions** (`/admin/people/permissions`) only to trusted
administrators before configuring the module.

## Enter your IVW/SZM identifiers

Open the module's settings form (administered behind the permission above) and enter
the **offering identifiers/codes** IVW/INFOnline issued for your site. These are the
values that tie the measurement data to your account in the SZM (SZM 2) system.

## Tune the codes per content type with tokens

IVW measurement often needs a **different code for different sections** of a site.
This module handles that with **Token-based settings**: rather than a single global
value, you can set the IVW parameters per content type (and let them vary by context)
using tokens. Configure the token-driven values on the relevant content type so each
section reports under the correct IVW offering.

## Consent and privacy — do not skip this

Because this tracking **sends usage data to the IVW/INFOnline measurement service**,
it is subject to consent and disclosure obligations:

- **Obtain consent** before the tracking runs for a visitor.
- **Integrate it with your cookie-consent / consent-management** solution so the
  tracking only fires when the visitor has agreed.
- **Disclose the tracking** in your privacy policy in line with **German and EU law
  (TTDSG / GDPR)**.

Treat enabling the tracking and satisfying these obligations as a single step — the
measurement should not be live for real visitors until consent handling is in place.

## Save

Save the settings form. With identifiers entered, per-content-type tokens configured,
and consent handling wired up, IVW/SZM tracking is added to your pages.
