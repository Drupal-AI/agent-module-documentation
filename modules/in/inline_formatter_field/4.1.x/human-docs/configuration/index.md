# Configuration

Most of your work with Inline Formatter Field happens on each entity's **Manage
display** tab (see [How to use it](../index.md#how-to-use-it)). But the module also
has one **global settings form** that controls the in‑browser ACE Editor used for
writing your HTML/Twig, and which text editor profile the field uses by default.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Inline Formatter Field Settings**, or navigate directly
   to `/admin/config/inline_formatter_field/settings`.

## Settings, field by field

- **Default editor** (`default_editor`) — the text editor profile used for the
  Inline Formatter Field's templating. It defaults to the **IFF Ace Editor**
  (`iff_ace_editor`) profile the module creates on install, but you can point it at
  another editor here.
- **Ace source** (`ace_source`) — the path or URL from which the ACE Editor
  JavaScript library is loaded. Adjust this if you host the library locally or from
  a specific location.
- **Ace theme** (`ace_theme`) — the default ACE Editor color theme for the code
  editor.
- **Ace mode** (`ace_mode`) — the default ACE Editor syntax mode (for example, an
  HTML or Twig mode) applied to the editor.
- **Available themes** (`available_themes`) — a list of key/value pairs defining
  which ACE Editor themes editors can choose from.
- **Available modes** (`available_modes`) — a list of key/value pairs defining
  which ACE Editor syntax modes are offered.
- **Extra options** (`extra_options`) — a list of key/value pairs for any
  additional ACE Editor settings you want to apply.

## Per‑user preferences

The theme, mode, and extra settings above are **defaults**. On the Manage display
form, each editor can override the theme and mode to suit their own taste; those
choices are remembered in a browser cookie for the site. If no cookie is found,
the defaults from this form are used.

## Save

Click **Save configuration**. The new defaults apply the next time an editor opens
the code editor on a Manage display form.
