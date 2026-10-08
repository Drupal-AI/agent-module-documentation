# Configuration

CAS Attributes has one settings form that writes one config object,
`cas_attributes.settings`.

## Open the settings form

1. Log in as a user with the **Administer account settings** permission.
2. Go to **Configuration → People → CAS → CAS Attributes**, or navigate directly to
   `/admin/config/people/cas/attributes`.

The form is grouped into three sections.

## General Settings

- **Sitewide token support** — a checkbox. Tick it if you want `[cas:attribute:…]` tokens
  to work *anywhere* on the site (webforms, blocks, mail bodies, the *Available Attributes*
  page). You do **not** need this just to fill user fields — field mappings work regardless.
  When ticked, an **Allowed Attributes** textarea appears: list one attribute name per line
  to restrict which attributes are exposed as tokens (a good idea for privacy). Leave it
  empty to expose all of them. Names are stored lower-cased.

## User Field Mappings

This section copies attribute values into user account fields.

- **Sync frequency** — choose when field mappings apply: *Never*, *Initial registration
  only*, or *Every login*.
- **Overwrite** — when ticked, a mapping replaces an existing field value; when unticked,
  it only fills a field that is currently empty.
- **The per-field boxes** — the form offers the username (`name`), the email (`mail`), and
  every eligible custom field on the user account. Only fields of type *string*, *list
  (text)* or *integer* are offered — there is no support for references, dates or multi-
  value fields. Type a token string into each field you want populated, for example
  `[cas:attribute:email]` for the email or `[cas:attribute:displayname]` for the username.
  You can pick one value out of a multi-value attribute with a modifier, e.g.
  `[cas:attribute:ou:first]`.

An empty result leaves the field untouched — you cannot use a mapping to *clear* a field.

## User Role Mappings

This section grants or removes Drupal roles based on attribute values.

- **Sync frequency** — *Never*, *Initial registration only*, or *Every login*, controlling
  when roles are actually added to or removed from the account.
- **Deny login when no role matches** — when ticked, a CAS user who matches none of the
  role rules is refused login entirely. Note this check runs on every login regardless of
  the sync frequency above.
- **Deny registration when no role matches** — when ticked, CAS auto-registration is
  refused for a would-be user who matches no rule.
- **Role Mapping rows** — each row is one condition, with these fields:
  - **Role** — the role to grant (the *authenticated* role is never offered).
  - **Attribute** — the CAS attribute name to look at (compared case-insensitively).
  - **Value** — the value to compare against (for the regex method, this is the full
    pattern including delimiters).
  - **Method** — how to compare: *exact single* (attribute has exactly one value equal to
    yours), *exact any* (any value equals yours), *contains any* (any value contains yours
    as a substring), or *regex any* (any value matches your regular expression).
  - **Negate** — grant the role when the comparison *fails* instead of when it passes.
  - **Remove without match** — remove the role when the comparison fails. Use with care:
    this also strips a role that was granted by hand.

  A blank row is always shown at the bottom for adding another mapping; existing rows gain
  a *Remove this mapping?* checkbox. A row is only saved if its Role, Attribute and Value
  are all filled in.

Click **Save configuration** when you are done.

## Good to know

- **Field-mapping tokens work even with sitewide token support off** — the module passes
  the attributes straight into the token replacement for those. Sitewide support is only
  needed for tokens used elsewhere on the site and for the *Available Attributes* page.
- *Initial registration only* for field mappings requires CAS's own **Auto register
  users** setting to be on, otherwise no registration event ever fires.
- `deny login when no role matches` is evaluated on every login even when the role sync
  frequency is *Never* — so you can enforce access without continuously rewriting roles.
- Only *string*, *list (text)* and *integer* user fields appear in the field-mapping form.
