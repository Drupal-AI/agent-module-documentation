# CAPTCHA Questions — manual setup guide

**CAPTCHA Questions** (`captcha_questions`) is a lightweight question-and-answer
CAPTCHA. Rather than making visitors decode a distorted image, you write a simple
question — "What is the capital of France?", "What is 1+1?", or even one that
includes the answer, like "What is Mickey's last name? It's Mouse" — and attach it
to the forms you want to protect. If the answer is wrong, the form will not submit.
Answers are matched case-insensitively, and you can allow multiple acceptable
answers.

It is deliberately simple. It has **no dependencies** (it is *not* affiliated with,
and does not require, the CAPTCHA module), and it ships an optional
`captcha_questions_dblog` submodule that logs activity to the database if you want a
record. It works well against the everyday comment-spam and account-registration
bots that most sites face — the guidance from the maintainers is to keep questions
as simple as possible for humans while still tripping up automated scripts.

Set expectations accordingly: a static question-and-answer CAPTCHA is **weak against
a targeted attacker**, because a fixed question/answer pair can be scripted once it
is known. It is best suited to low-sophistication bot spam. For serious or targeted
abuse, rotate your questions periodically and combine it with stronger controls such
as rate limiting, a honeypot, or a cryptographic CAPTCHA.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   (optionally) the logging submodule.

## Where it lives in the admin menu

CAPTCHA Questions is configured from its **Configure** link on the modules list
(**Extend** / `/admin/modules`) once enabled; help and its permission settings are
reachable from there too. It has no access-control role of its own beyond its
permission.

## How to use it

1. After enabling the module, open its configuration from the modules list.
2. Create a **question/answer pair** — the question shown to the user and the
   answer(s) you will accept. Multiple acceptable answers are allowed, and matching
   is case-insensitive.
3. **Attach the question to the forms** you want to protect (comment forms,
   registration, and webforms — the module can automatically discover webforms, and
   supports custom form IDs and multi-page forms).
4. Test the form as an anonymous user: an incorrect answer should block submission.

To keep a database record of activity, also enable the optional
`captcha_questions_dblog` submodule (see [Installation](installation/index.md)).
