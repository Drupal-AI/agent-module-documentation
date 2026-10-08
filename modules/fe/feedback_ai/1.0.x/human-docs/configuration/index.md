# Configuration

Feedback AI needs one thing before it can do its job: a working connection to the
OpenAI API. You configure that on the module's settings form, reachable under
**Configuration** once the module is enabled (you'll need the **Administer site
configuration** permission, or the module's own admin permission).

## Connect to OpenAI

- **OpenAI API key** — enter your OpenAI API secret key here. This is what
  authorises the module's calls to OpenAI's Chat Completions API, and without it no
  sentiment analysis can run. The key is saved to the module's configuration when
  you submit the form; treat it as a secret and restrict who can administer the
  module (see the note in [Installation](../installation/index.md)).
- **Model** — the module works with OpenAI chat models such as **GPT‑4**, **GPT‑4
  Turbo**, and **GPT‑3.5 Turbo**. Choose the model that suits your balance of cost
  and quality — the smaller/faster models are cheaper per call, the larger models
  more capable.

Save the form once your key and model are set.

## Cost and privacy

Keep in mind that **every feedback submission triggers an OpenAI API call**, which
OpenAI bills. On a high‑traffic site those calls add up, so monitor your OpenAI
usage. The feedback text is also **sent to OpenAI** for analysis, so make sure
sending that content off‑site is acceptable for the kind of data your users submit.

## Permissions

Feedback AI defines its own permission(s). Review them at **People → Permissions**
and grant them only to the roles that should administer the module or view the
analysed feedback.

## Reviewing and exporting results

Analysed feedback (scored Positive / Negative / Neutral) is surfaced through Views,
and the required **Views Data Export** module lets you export those results for
reporting when you need them.
