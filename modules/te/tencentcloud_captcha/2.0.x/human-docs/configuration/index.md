# Configuration

TencentCloud Captcha needs two things before it does anything: your Tencent Cloud
credentials, and a decision about which forms should show the challenge. Both are
done through the admin UI.

## Step 1 — Gather your Tencent credentials

From the Tencent Cloud consoles, collect:

1. A **SecretId** and **SecretKey** from the Tencent Cloud API console. These
   identify your account to Tencent's verification API.
2. A **CaptchaAppId** and **AppSecretKey** for a *graphic captcha* (图形验证),
   created in the Tencent Cloud Captcha console. These identify the specific
   CAPTCHA instance shown to your visitors.

Treat all four values as secrets. Store them securely — ideally as environment
variables (env‑backed) — rather than committing them to your repository.

## Step 2 — Enter the credentials

1. Log in as a user who can administer CAPTCHA settings.
2. Go to **Configuration → People → CAPTCHA → TencentCloud**, or navigate directly
   to `/admin/config/people/captcha/tencentcloud_captcha`.
3. Fill in the **SecretId**, **SecretKey**, **CaptchaAppId**, and **AppSecretKey**
   fields with the values you gathered above.
4. On the same form, choose **which forms** TencentCloud Captcha should protect.
5. Save the form.

## Step 3 (optional) — Protect more forms via the CAPTCHA module

The main CAPTCHA settings page lets you apply any challenge — including this one —
to additional forms across your site. Go to **Configuration → People → CAPTCHA**
(`/admin/config/people/captcha`) and add form IDs, choosing TencentCloud as the
challenge type where you want it. This is how you extend protection beyond the
forms offered directly on the TencentCloud settings form.

## How verification works

When a protected form is submitted, the visitor's CAPTCHA response is verified
**server‑side** against Tencent's API using your secret credentials. Because the
check happens on the server rather than in the browser, a response cannot simply
be spoofed client‑side. If Tencent's API is unreachable, submissions to protected
forms will fail their challenge — worth keeping in mind for sites whose visitors
or servers may have intermittent access to Tencent's endpoints.
