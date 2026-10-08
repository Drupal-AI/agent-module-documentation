# Configuration

Masked Input is configured on its settings page, where you tell the module which
mask to apply to which field. Once a field has a mask, the placeholder pattern
appears as soon as someone focuses the field, and their typing snaps into that
shape.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → User interface → Masked Input**, or navigate directly
   to `/admin/config/user-interface/masked_input`.

## The mask characters

A mask is a short pattern built from these placeholder characters (everything else
in the pattern — brackets, dashes, spaces — is shown literally):

| Character | Accepts |
|-----------|---------|
| `9` | a digit (0–9) |
| `a` | a letter (A–Z, a–z) |
| `*` | any alphanumeric character (A–Z, a–z, 0–9) |

Some common masks:

- `(999) 999-9999` — a US phone number
- `99-9999999` — a US tax ID
- `999-99-9999` — a social‑security number
- `a*-999-a999` — a product code
- `99%` — a percentage

## Apply a mask to a field

On the settings page, pair the field you want to mask with the mask pattern it
should use. In practice you identify the target field (for example by its CSS ID)
and enter the pattern for it, the same way the underlying plugin is invoked as
`$("#field-id").mask("(999) 999-9999")`. Add one entry per field you want masked.

If you would rather use a different placeholder than the default underscore
(`_`), the plugin supports a custom placeholder character; consult the module's
`README` for how to set it in your configuration.

## Save

Save the form, then load a page containing one of the targeted fields. The mask
should appear when you focus the field, and your typing should follow the pattern.

> **Remember:** the mask only guides input in the browser. It is not validation.
> Keep server‑side validation in place for any value whose format actually
> matters, and never assume a masked field's value is clean just because the mask
> was shown.
