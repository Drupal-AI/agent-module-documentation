# Configuration

Getting the admin language working is a four-part job: turn the detection method
on and place it first, tell the module which pages count as "admin", grant the
permission, and set each user's preferred admin language. You need at least two
languages configured on the site for any of this to have an effect.

## 1. Turn on and order the detection method

The "Administration language" method must be enabled for the **interface** (UI
text) language type, and it must sit **above** Drupal's other detection methods
(URL, browser, and so on) so that it wins on admin pages.

1. Go to **Configuration → Regional and language → Languages → Detection and
   selection** (`/admin/config/regional/language/detection`).
2. In the **Interface text language detection** section, tick
   **Administration language** to enable it.
3. Drag it to the **top** of the list (the topmost enabled method runs first).
4. Click **Save settings**.

If it is not placed above URL/browser detection, those methods will decide the
language first and the admin language will never apply.

## 2. Choose which pages count as "admin"

Open the module's own settings form at **Configuration → Regional and language →
Languages → Detection and selection → Administration language**
(`/admin/config/regional/language/detection/administration_language`). This form
requires the core *Administer languages* permission. It has three settings:

- **Paths** — a list of location patterns where the admin language should apply.
  The defaults are `/admin`, `/admin/*`, `/admin*`, `/node/add/*`,
  `/node/*/edit`, `/node/*/translations`, and `/node`. `*` is a wildcard, and
  `<front>` matches the front page. Language URL prefixes (for example
  `/de/admin`) are matched too, so prefixed admin URLs still trigger the admin
  language. Add your own paths here — for example a custom `/dashboard/*` — one
  per line.
- **Admin routes** — when ticked, the admin language applies on *every* admin
  route (anything Drupal itself treats as an admin page), in addition to the
  paths above. This is a convenient catch-all if you would rather not maintain a
  path list.
- **Use default language** — when ticked, users who have not chosen a preferred
  admin language fall back to the site's default language on admin pages, instead
  of being left on whatever the front end negotiated.

Click **Save configuration** when you are done.

## 3. Grant the permission

The method only runs for users who hold the **Administration language
negotiation** permission (`use administration language negotiation`). Grant it at
**People → Permissions** (`/admin/people/permissions`) to any role that should be
able to choose an admin language — including non-administrator roles such as
editors or translators. Its description reads: *"Gives the option to select a
preferred administration language even if not an administrator."*

Note the two permissions are separate: this permission controls *who gets* an
admin language, while the settings **form** above is protected by the core
*Administer languages* permission.

## 4. Set each user's preferred admin language

For users who have the permission, the module unhides the core **"Administration
pages language"** field on the user edit form (**People →** *edit a user*, or
`/user/{uid}/edit`). Whatever language a user picks there is what they will see on
the admin pages you defined in step 2. If a user leaves it unset, they get either
the site default (when *Use default language* is on) or the normally negotiated
language.

## How it decides, in short

For a permitted user on a matching admin location, the method returns that user's
preferred admin language (with the optional default-language fallback). On any
other page it stays out of the way and lets the next detection method decide.
Developers can extend which requests count as "admin locations" by adding a
condition plugin — see the [`agent/`](../agent/start.md) docs.
