# Configuration

GovCMS DLM adds a settings form where you set the **default email protective
marking**. Only a user granted the module's administer permission can open it.

## The default protective marking

This is the single setting that matters: the text of the Dissemination Limiting
Marker that will be appended to the subject line of outgoing email. Typical
values look like:

- `[SEC=UNOFFICIAL]`
- `[SEC=OFFICIAL]`
- `[SEC=OFFICIAL:Sensitive]`

Enter the marking your agency requires. Once saved, it is applied automatically
to mail sent through Drupal's mail system, so you do not need to change any of
your existing notification, webform or account‑email configuration.

Follow the **Email Protective Marking Standard for the Australian Government**
(published by the Department of Finance) for the exact syntax and the marking
appropriate to your content. If you are unsure which marking applies, check with
whoever is responsible for information security at your agency rather than
guessing.

## Save

Save the form and send yourself a test email to confirm the marking appears on
the subject line.

## An important caveat

The marking is a **classification label, not protection**. It tells recipients
and mail systems how the information should be handled, but it does not encrypt
or otherwise secure the message. Make sure your site and mail relay use proper
transport security (TLS) so the content is protected in transit — the DLM does
not do that job.
