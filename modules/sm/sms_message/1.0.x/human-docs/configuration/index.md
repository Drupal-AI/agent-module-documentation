# Configuration

SMS Message works as a pairing between Drupal (which holds the messages) and an
Android app (which sends them). Configuration is about securing the API endpoint
and connecting the app.

## Set the endpoint token

1. Open the module's **SMS settings** page (its configuration / *Sms setting*
   screen).
2. The module generates a **token** used to secure the API endpoint. You can keep
   the generated value or set your own. Your endpoint URL is then:

   ```
   https://yoursite.com/api/sms/YOURTOKEN
   ```

Because the endpoint is protected **only by this token in the URL**, choose a
long, unguessable value, serve your site over HTTPS, and keep the URL private —
anyone who has it can read your pending messages, and with the `?action=delete`
parameter can download them all at once and clear them from the server. You can
also customise how often the app polls (the app default is every 2 minutes; you
can set shorter intervals, e.g. 0.5 minutes for 30 seconds).

## Connect the Android app

1. Install the companion *send sms* app on your Android phone (the APK linked from
   the project, ~6 MB), or build it yourself from the project's `sms-android`
   folder.
2. Open the app and send one SMS to test it — grant the SMS permission when
   prompted.
3. Add your Drupal endpoint (`https://yoursite.com/api/sms/YOURTOKEN`) into the app.
4. Tap the **On Service** button.

The app then polls the endpoint on its interval, downloads any unsent messages,
and sends them through your phone's SMS service.

## Create and queue messages

There are three ways to create messages that the app will pick up:

- **Manually** — at `/admin/content/sms-message`.
- **Programmatically** — create an `sms_message` entity in custom code:

  ```php
  $sms = \Drupal::entityTypeManager()->getStorage('sms_message')->create([
    'type' => 'sms_message',
    'number' => $phoneNumber,
    'message' => ['value' => $message],
    'uid' => $user_id,
  ]);
  $sms->save();
  ```

- **In bulk with Views Bulk Operations** — to text a whole customer base, create a
  customer content type with a **required phone field** and a **taxonomy** holding
  your SMS templates. Build a VBO View over the customers, enable the VBO **SMS
  message** action, and in its config choose the phone field and the template
  vocabulary. When you run the operation it asks which template term to send.

## Data‑handling reminder

Recipients' phone numbers are personal data, and bulk texting is subject to
consent and carrier rules — only message people who have agreed to hear from you,
and don't use this to send unsolicited SMS.
