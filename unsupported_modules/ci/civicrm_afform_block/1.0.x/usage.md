<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CiviCRM Afform Block

Places a CiviCRM Afform on Drupal pages through a standard block.


## What & when

- Use it to embed a CiviCRM FormBuilder (Afform) form, search display or system directive anywhere Drupal blocks can go.
- Requires a working CiviCRM install (the `civicrm` module) and core `block`.
- The block loads CiviCRM's Angular loader and core resources, then renders the selected Afform directive.

---

## Install & configure

- `composer require drupal/civicrm_afform_block` then `drush en civicrm_afform_block -y` (CiviCRM must be installed first).
- Place the **CiviCRM Afform Block** via *Structure → Block layout* (or Layout Builder).
- In the block form, pick the Afform from the **CiviCRM Form Name** select — options come from `Afform::get()` filtered to types form/search/system.
- On save the block resolves and stores the Afform's `directive_name` plus its machine name in block config.
- Access to the block is governed by normal block visibility/role settings; the Afform enforces its own CiviCRM permissions when rendered.

---

## Usage & behaviour

- Show a CiviCRM contribution / event / profile form inside a Drupal region.
- Embed a CiviCRM SearchKit display block on a Drupal page.
- Reuse one Afform in multiple places by placing multiple block instances with different form selections.
- The list of selectable forms is pulled live from CiviCRM at block-configuration time.
- Rendering is done via `hook_block_build_..._alter` which calls `Civi::service('angularjs.loader')->addModules()`.
- The block theme (`civicrm_afform_block`) receives `#name` (module_name) and `#directive` variables.
- Form option labels use the Afform title, falling back to its machine name when no title is set.
- Only Afforms of type `form`, `search`, or `system` are offered.
- Works with Drupal core block layout and Layout Builder.
- No module-specific permissions are defined; standard `administer blocks` is required to place/configure it.
- Best paired with CiviCRM's own permission model for controlling who can submit the embedded form.
- Useful for exposing CiviCRM public forms (donations, sign-ups) on marketing pages.
- The directive name is resolved server-side, so front-end users only receive the rendered Afform.
- Multiple Afforms on one page are supported (CiviCRM loads each directive's module).
- No Drush commands or routes are added by this module.
