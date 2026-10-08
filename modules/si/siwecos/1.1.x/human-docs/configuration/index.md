# Configuration

Setting Siwecos up is a matter of registering with the service and then handing
your credentials to the module, which does the domain registration and scanning
for you.

> **One thing to know first.** The settings form requires a permission
> (`administer siwecos configuration`) that the module never defines, so in
> practice only **user 1** (the superuser) can open it.

## 1. Register with SIWECOS

Create a free account at the SIWECOS project site (siwecos.de) and note the email
and password you signed up with. Those are the credentials the module uses.

## 2. Open the settings form

Log in as user 1 and go to **Configuration → System → Siwecos**, or navigate
directly to `/admin/config/system/siwecos`. If the module is not yet configured,
the page shows a prompt reminding you to register for a free SIWECOS account.

## 3. Fill in the fields

- **Email** — the email address of your SIWECOS account.
- **Password** — the password of your SIWECOS account.

The remaining fields on the form — the **domain**, the **domain token**, and the
**API token** — are managed by the module rather than typed in by you. The domain
field is locked to your current site's host, which is what guarantees scans only
ever target your own site. When you save, the module logs in to SIWECOS, obtains
an API token, and registers and verifies your site's front-page domain
automatically, populating those read-only fields for you.

## 4. Verify domain ownership

Verification happens automatically: the module adds a `siwecostoken` meta tag to
your pages and also sends it as a response header, which SIWECOS checks to confirm
you control the domain. You do not need to paste anything by hand.

## 5. View the report

Once a scan has run, go to **Reports → Siwecos** (`/admin/reports/siwecos`) to see
the overall security score as a colour-coded circle, with each scanner's findings
in collapsible sections. The score is also added to Drupal's status report
requirements.

## Optional: place the trust seal

The module provides a **Siwecos seal** block. Place it from **Structure → Block
layout** in whichever region you like to display a verification badge that links
back to siwecos.de.

## Recommended companion modules

In a typical Drupal setup the scanners often flag Content-Security-Policy issues.
The project suggests pairing Siwecos with **Security Kit** (for a range of
security-hardening options) and the **Content-Security-Policy** module (to add
proper CSP headers) to improve your score.
