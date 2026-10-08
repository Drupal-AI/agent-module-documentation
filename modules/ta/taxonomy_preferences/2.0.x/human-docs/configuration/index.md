# Configuration

Setting up Taxonomy Preferences has three parts: choose which terms visitors can pick,
place the block, and (optionally) connect a View that reacts to their choices.

## 1. Choose the offered terms

1. Log in as a user with the **access taxonomy preferences settings** permission.
2. Go to **Configuration → System → Taxonomy Preferences**, or navigate to
   `/admin/config/system/taxonomy_preferences`.
3. **Select the vocabularies** you want to draw from.
4. **Select the terms** that should be offered to the visitor in the block. This lets
   you present a curated subset of a large vocabulary rather than every term.
5. Optionally, enter a **message** string to display above the checkboxes (for
   example "Pick the topics you're interested in"). This string is translatable —
   use the **Translate** tab to provide per-language versions.
6. Click **Save configuration**.

## 2. Place the preferences block

Once you have saved the settings, a **Taxonomy Preferences** block becomes available.
Go to **Structure → Block Layout** (`/admin/structure/block`) and place the block in
a region — a sidebar is a natural choice. Visitors will see the offered terms as
checkboxes; when they submit, their selection is stored in their session. (On the
front page, the form redirects back to the front page after submission.)

Control who sees the block form with the **access taxonomy preferences block**
permission.

## 3. Connect a View (optional but the point of it)

The stored selection lives in `$_SESSION['taxonomy_preferences']['preferences_key']`
as a `+`-joined list of term IDs. To turn that into a filtered content listing, use
the **Views Extender / Views Extra** module, which offers a contextual filter based
on a session variable:

- In your View's session-based contextual filter, set the **Session variable key** to
  `taxonomy_preferences::preferences_key`.

The View will then filter its results to the terms the visitor selected. There is also
a `visibility` session flag you can use to conditionally render content depending on
whether the visitor has made a selection.

## Permissions summary

| Permission | What it allows |
|------------|----------------|
| `access taxonomy preferences settings` | Open and save the settings form. |
| `access taxonomy preferences block` | See / use the preferences block form. |

## A note on access

The block's submit route is gated only by the core **access content** permission, so
anonymous visitors can submit preferences. That is intentional and safe here: a
submission only writes the visitor's *own* session data — it does not change any
server-side or shared state. The admin **message** is rendered as raw markup, so keep
it as trusted administrator (or config-translation) input.
