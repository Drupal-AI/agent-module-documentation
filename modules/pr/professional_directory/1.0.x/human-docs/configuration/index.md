# Configuration

Setting up Professional Directory has two parts: the **settings form**, where you
describe your directory and its emails, and the **permissions**, which decide who
can moderate and who can enter the private member area.

## Open the settings form

1. Log in as a user with the **Administer professional directory** permission.
2. Go to **Configuration → Professional Directory**
   (`/admin/config/professional-directory`).

## Settings

The settings form lets you tailor the directory and the messages it sends:

- **Directory name** — the display name for your directory.
- **Professional categories** — the set of categories professionals can be listed
  under, so applicants can classify themselves and members can be browsed by type.
- **Registration window / dates** — the period during which the public signup
  form accepts applications, letting you open and close registration.
- **Notification emails** — the configurable HTML content for the emails sent when
  an application is **validated** and when it is **rejected** (and for contact-
  request notifications), so the wording matches your organisation's voice.

Save the form to apply your changes.

## Permissions

Go to **People → Permissions** (`/admin/people/permissions`) and set:

- **Access professional directory private area** — grant this to the role your
  approved members hold, so validated professionals can reach the private
  directory and use contact requests.
- **Administer professional directory** — this restricted permission controls the
  settings form and the moderation overview (validating/rejecting applications and
  managing profiles). Keep it to staff only.

## Moderating applications

Approved and pending applications are managed at **Content → Professional
Directory** (`/admin/content/professional-directory`). From there you validate or
reject each incoming signup. A rejected profile is kept out of the directory
listings and its accreditation file stays inaccessible.

## Privacy notes

The module collects real personal information (profile details and accreditation
files). A few built-in protections are worth knowing about, and one thing to add:

- The private area only ever shows a member their **own** validated profile, and
  anonymous visitors are redirected to log in.
- Accreditation file downloads are restricted to an administrator or the file's
  owning, validated professional — other users can't retrieve them by guessing an
  ID.
- **Add a CAPTCHA** to the public signup form (see Installation) to keep automated
  submissions out of your moderation queue.
