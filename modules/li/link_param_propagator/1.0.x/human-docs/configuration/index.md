# Configuration

All of Link Param Propagator's behaviour is defined here as **rules**. Each rule
says *which* parameters to carry and *where* on the page to apply them.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → System → Link Param Tracking**, or navigate directly to
   `/admin/config/system/link_param_propagator`.

## Add a rule

Click **Add another rule** and fill in its fields (rules are managed with AJAX
controls, so you can add, relabel, or delete them without a full page reload):

- **Rule Label** — a human‑friendly name for the rule so you can tell your rules
  apart, for example "Campaign UTMs" or "Partner referrals".
- **Tracking Parameters** — the query parameters this rule should propagate,
  entered as a **comma‑separated list**, for example `utm_source, utm_medium,
  utm_campaign, ref`. Only these named parameters are appended.
- **Target DOM Selector** — a CSS selector identifying the region whose links the
  rule applies to, for example `#main-content` or `.promo`. Links outside the
  matched region are left untouched, which lets you keep tagging tightly scoped
  and avoid over‑tagging the whole page.

## Multiple rules

Add as many rules as you need — for example one set of parameters for your main
content area and a different set for a promotional block. Each rule carries its
own parameter list and selector independently.

## Save

Click **Save configuration**. From then on, as visitors browse, the module
appends the matching parameters to the links inside each rule's target region.
Stored content is never modified — the parameters are added client‑side at render
time, so the effect is visible in the browser and requires JavaScript.
