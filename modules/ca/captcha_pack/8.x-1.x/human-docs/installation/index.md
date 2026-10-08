# Installation

## Requirements

- **Drupal 9.5 or 10** (`core_version_requirement: ^9.5 || ^10`).
- The **CAPTCHA** module (`captcha`) — required; every challenge type in the pack
  plugs into it and relies on it for server-side validation.

There are no additional PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/captcha_pack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The CAPTCHA module is pulled in as a dependency if it is not
already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/captcha_pack -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

CAPTCHA Pack is really a collection of submodules — there is no single "captcha_pack"
component to turn on. Enable the CAPTCHA module plus whichever challenge types you
want. For example, to add the math CAPTCHA:

```bash
drush en captcha math_captcha -y
```

## Submodules — enable only the challenge types you need

| Submodule | What it adds |
|-----------|--------------|
| `math_captcha` | A configurable arithmetic challenge ("two plus three equals ?", "2 * ? = 6"). |
| `text_captcha` | Shared base for the text-manipulation challenges below. |
| `lost_character_captcha` | The user supplies the missing character(s) from a word, e.g. "yeste_day". |
| `phrase_captcha` | The user picks the correct word from a phrase. |
| `word_list_captcha` | The user selects the word that does not belong, e.g. "blue green cat red". |
| `css_captcha` | Text scrambled in the markup but rendered correctly by a CSS-capable browser. |
| `ascii_art_captcha` | A random code rendered in figlet-style ASCII art. |
| `foo_captcha` | A trivial example: the user types "foo". Demo/very weak. |
| `random_captcha_type` | A meta type that picks a random one of your enabled types per submission. |

Enable each one individually with `drush en <machine_name> -y`. The
`lost_character_captcha`, `phrase_captcha`, and `word_list_captcha` types build on
`text_captcha`, which is enabled automatically as their dependency.

## Verify it worked

Go to **Configuration → People → CAPTCHA** (`/admin/config/people/captcha`). The
challenge types from the submodules you enabled should now be selectable. Assign one
to a test form (for example user registration), then load that form as an anonymous
user and confirm the challenge appears and validates.
