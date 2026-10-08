# Configuration

Setting up Hover Card is two quick jobs: grant the permission that lets people see
cards, then choose what each card shows.

## Grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and set:

- **View hover cards** — allows a role to *see* hover cards. Grant it to the roles
  (and, if you want, to **anonymous** visitors) who should get the popup on hover.
- **Administer Hover Card settings** — allows configuring the module. Keep this with
  administrators.

Save permissions.

## Open the settings form

Go to **Configuration → People → Hover Card**, or navigate directly to
`/admin/config/people/hover-card`.

## Choose which fields appear

The settings form lets you toggle the visibility of each piece of information the
card can show:

- **User picture** — the account's profile image.
- **Email** — the user's email address. Think twice before enabling this if the card
  is visible to anonymous or untrusted visitors.
- **Roles** — the user's assigned roles.
- **Member since** — the account creation date.
- **Last access** — when the user was last active.

### Custom user fields

Hover Card automatically **discovers any custom fields** you've added to the user
entity — text, numbers, booleans, dates, email, links, entity references, images,
and list fields are all supported. They appear in a **Custom User Fields** section
of the settings form; simply tick the ones you want the card to display. To show a
**bio or description**, add a text field to the user entity and enable it here.

> **Privacy reminder:** only enable fields that are safe to reveal to whoever can
> see the card. Field choices should respect who is allowed to see that data — be
> especially careful with email and any sensitive custom fields when the **View
> hover cards** permission is granted to anonymous users.

## Advanced settings — which links trigger a card

The form includes an advanced **CSS selector** setting that controls which links on
the page open a hover card. The default works with the Olivero theme (in both
teaser and full view modes) and common author markup:

```
a.username, span[rel="schema:author"] > a, span.node__author a, .node__meta a[href*="/user/"]
```

If your theme marks up user links differently and cards aren't appearing, adjust
this selector to match your theme's markup.

## Save

Click **Save configuration**. Changes take effect after a normal cache clear if the
page is cached; the card reflects your field choices on the next hover.

## Styling the card (optional)

The card uses BEM CSS classes so you can restyle it in your theme — for example
`.hover-card` (the container), `.hover-card__image`, `.hover-card__name`,
`.hover-card__mail`, `.hover-card__roles`, and field‑specific modifiers like
`.hover-card__field--{fieldname}`. For complete control you can copy the module's
`hover_card.html.twig` template into your theme and customise it.
