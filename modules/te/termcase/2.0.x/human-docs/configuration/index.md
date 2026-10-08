# Configuration

Termcase is configured per vocabulary, directly on that vocabulary's edit form —
there is no central settings page.

## Set the case convention for a vocabulary

1. Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`) and click **Edit**
   on the vocabulary you want to control (or edit it at
   `/admin/structure/taxonomy/manage/{vocabulary}`).
2. Find the **Term case settings** fieldset on the form.
3. Choose one of the five modes:
   - **No formatting** — Termcase leaves term names exactly as typed. Use this to
     switch enforcement off for the vocabulary.
   - **Ucfirst** — converts the first character of the term to uppercase (for
     example, *news* → *News*).
   - **Lowercase** — converts the whole term to lowercase (*News* → *news*).
   - **Uppercase** — converts the whole term to uppercase (*News* → *NEWS*).
   - **Propercase** — capitalises the first letter of each word (*breaking news* →
     *Breaking News*).
4. Save the vocabulary.

From now on, every term saved in that vocabulary — whether added by an editor or
created through an import — has its name re‑cased to the chosen convention on save.
On the term add/edit form, a note explains which conversion will be applied, so
editors know what to expect.

## Convert existing terms

Setting a mode only affects terms saved *after* you save it — existing terms are
left as they are until you convert them. You have two ways to do that:

- **From the vocabulary form:** the same **Term case settings** fieldset includes
  a checkbox to convert all existing terms immediately. Ticking it and saving runs
  a Batch API job across every term in the vocabulary, applying the chosen case.
- **From the command line:** the module ships a Drush command that performs the
  same bulk conversion, handy for large vocabularies or scripted deployments.

## Extending the conversion (for developers)

If the five built‑in modes are not enough, a module can implement
`hook_termcase_convert_string_alter` to apply additional formatting on top of the
selected mode, just before each term is saved (see `termcase.api.php`). This is
optional and not needed for normal use.
