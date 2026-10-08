# Configuration

Better Passwords has one settings page with three fields. Open it at **Configuration →
People → Passwords** (`/admin/config/people/passwords`). You need the **Administer
Better Passwords** permission (administrators have it by default).

The policy is **global** — there is no per‑role or per‑form override. Whatever you set
here applies to every core password field on the site: registration, the user‑edit form
(`/user/N/edit`), and the one‑time‑login password reset.

## Minimum length

A number field (default **8**). This is the fewest characters a password may contain;
the form quotes the NIST recommendation of at least 8. Raise it — for example to 12 or
16 — for a higher‑security site. Setting it to `0` (or leaving it empty) turns the
length check off entirely, so you can run a strength‑only policy if you prefer. Under
the password field, users see a live reminder such as *"Passwords must be at least 8
characters."*

## Minimum strength

A select list controlling the lowest acceptable **zxcvbn** score. The options are:

- **Strongest** (score 4)
- **Strong** (score 3) — the default
- **Moderate** (score 2)
- **Weak** (score 1)
- **Do not check strength** (score 0) — disables the strength check

zxcvbn rates a password from 0 (trivial to crack) to 4 (very strong), penalising common
passwords, dates, years, purely numeric strings, repeats, sequences, and
keyboard‑adjacent runs — and it treats the user's own name and email as dictionary
words, so a password built from them scores lower. Whatever you pick here is the
*minimum*: choosing **Strong** rejects anything zxcvbn rates 0–2. When a password falls
short, the user gets *"Please choose a stronger password"* followed by a bulleted list
of the specific weaknesses (for example "Your password must not be a date", "…must not
match a common password", "…must not be sequential"). Users also see a general reminder
that *"Passwords will be rated for their strength."*

## Auto‑generate password

A select list controlling whether accounts an **admin creates** get a strong,
auto‑generated 64‑character initial password. This only affects the user‑register form
when it is submitted by a logged‑in user (an admin creating an account) — it does not
change self‑registration by anonymous visitors. The options are:

- **Never** (0) — admins always type the initial password themselves.
- **Optional** (1) — the default. Adds an **"Auto‑generate password"** checkbox to the
  register form; ticking it hides the password fields and generates a strong password.
- **Required** (2) — hides the password fields entirely, so an auto‑generated password
  is always used and an admin can never hand‑pick a weak initial one.

## Save and deploy

Click **Save configuration** to apply the policy immediately. All three values live in
the `better_passwords.settings` configuration object, so you can export and import them
like any other simple config to deploy the same policy across environments.

## Who can change the policy

The single **Administer Better Passwords** (`administer better passwords`) permission
controls access to this settings page only. The password rules themselves are enforced
for **every** user regardless of permission — this permission just decides who may edit
the policy, so grant it only to trusted admin roles.
