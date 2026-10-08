# Configuration

Configuration is a two‑part job: create the collector in JIRA and copy its embed
code, then paste that code into Drupal and decide where the widget shows.

## Step 1 — Create the collector in JIRA

1. In JIRA, open the **project administration** page for the project that should
   receive the feedback.
2. Add a **new issue collector** and configure it (the trigger text, the fields on
   the feedback form, and so on), then submit it.
3. Find the **"Embedding this Issue Collector"** section and **copy the code**.
   Either embed option works, but see the note below about jQuery.

## Step 2 — Paste it into Drupal

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → JIRA Issue Collector**
   (`/admin/config/system/jira_issue_collector`).
3. Paste the copied snippet into the **Embed code** field.
4. Adjust the remaining options — including which pages display the widget — and
   click **Save configuration**.

## Choosing where and to whom the widget appears

- Use the module's **display settings** to control which pages show the widget so
  it doesn't appear everywhere by default.
- Use the module's **permissions** (at **People → Permissions**) to restrict the
  widget to the right audience — typically staff and testers rather than all
  anonymous visitors.

## Privacy and a known jQuery caveat

- **External JavaScript:** the widget loads Atlassian's third‑party script into any
  page it appears on. Treat that as a privacy and supply‑chain consideration, and
  another reason to scope the widget to intended audiences and pages.
- **jQuery compatibility:** since Drupal 8.4 core ships jQuery 3, and the JavaScript
  Atlassian provides in the "existing JavaScript resource" embed option is not
  jQuery‑3 compliant. If you hit problems, use the **HTML embed option** instead.
