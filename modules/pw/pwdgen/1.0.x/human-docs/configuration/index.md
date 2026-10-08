# Configuration

Password Generator is used from a form rather than configured once and forgotten:
you supply a phrase and options each time you want a password. There is also a
symbol-settings form for customising the characters it can use.

## Generate a password (the admin form)

1. Go to **Configuration → People → Generate password**
   (`/admin/config/people/generate-password`).
2. **Insert text to encrypt** — type the phrase or set of words to build the
   password from. (The phrase must be at least 6 characters.)
3. **Select properties** — choose the options you want, such as including
   **symbols** and/or **numbers**, within the character-length limit.
4. Click submit. The generated password is displayed on the page for you to copy.

## Symbol settings

The module provides a settings form (route `pwdgen.admin_settings`) where you can
customise the symbols used when generating passwords, so the output matches whatever
character set your target system accepts.

## Generate from the command line (Drush)

pwdgen also ships a Drush command, `pwdgen:generate` (alias `pwdgen`), which builds
a password from a phrase:

```bash
# 12-character password (the default length) from a phrase
drush pwdgen:generate 'your text'

# 20-character password
drush pwdgen:generate --length=20 'your text'

# symbols only
drush pwdgen:generate --option=symbols 'your text'

# numbers only
drush pwdgen:generate --option=numbers 'your text'
```

Arguments and options:

- **Phrase** (argument) — the text to build from; must be at least 6 characters.
- **`--length[=LENGTH]`** — length of the password (default **12**).
- **`--option[=OPTION]`** — restrict the extra characters to `symbols` only or
  `numbers` only.

## A note on strength

The generator uses a cryptographically secure random source for its selections, so
the entropy is real. Still, the strength of any single password depends on the
length and complexity you pick — choose a longer length and include symbols and
numbers when the password protects something important.
