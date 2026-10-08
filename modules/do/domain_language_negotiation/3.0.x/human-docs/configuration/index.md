# Configuration

Domain Language Negotiation does not have a settings form of its own. Its
configuration lives in two places you already use: Drupal's core language
**Detection and selection** page, where you enable and order the method, and your
**domain records**, where you set each domain's language. Getting the order right
is the whole game.

## Step 1 — Set each domain's language

For every domain that should serve a specific language, set that language on the
domain record (under **Configuration → Domain**, using the domain language
settings). Only languages you have enabled site-wide are available. This is the
value the negotiation method reads.

## Step 2 — Enable the detection method

1. Log in as a user with the **Administer languages** permission.
2. Go to **Configuration → Regional and language → Languages → Detection and
   selection** (`/admin/config/regional/language/detection`).
3. In the list of detection methods, tick the checkbox to **enable** the domain
   negotiation method provided by this module.

## Step 3 — Get the order right (the critical part)

Drupal applies detection methods **top to bottom, and the first one that resolves
a language wins.** For the domain to be authoritative, this method must sit **above**
the methods that could otherwise answer first — in particular:

- **above "User" / session detection**, so a returning visitor's saved language
  choice does not override the domain, and
- **above "Browser" detection**, so a visitor's browser language preference does
  not override the domain.

Drag the domain method up the list accordingly, then click **Save settings**.

If you skip this, the classic symptom appears: a French domain serves English to a
returning visitor because their session language won the race. Whenever the
detected language looks wrong, check this ordering first.

## Verify

Load each domain in a fresh browser session and confirm it serves its configured
language. Then log in / revisit and confirm the domain still wins over any
remembered session or browser language — proof the method is ordered correctly.
