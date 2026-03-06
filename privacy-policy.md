---
layout: default
---

<div class="flex flex-col gap-2 pb-8">
    <h2 class="text-2xl font-black font-medium py-4">Privacy Policy</h2>
    <p>This Privacy Policy outlines how we collect and use anonymous analytics data on our website. We are committed to protecting your privacy and ensuring the security of your information.</p>

    <h3 class="text-xl font-black font-normal">Information We Collect</h3>
    <p>We collect anonymous analytics data using Posthog, which includes but is not limited to:</p>

    <ul class="list-disc list-inside">
        <li>Page views</li>
        <li>Number of visitors</li>
        <li>Browser information</li>
        <li>Referral sources</li>
    </ul>

    <p>We do not collect any personally identifiable information (PII) or use cookies on our website, as we're using Posthog in cookie-less tracking mode, with the following configuration:</p>

    <code>
    {<br/>
        api_host: 'https://eu.i.posthog.com',<br/>
        person_profiles: 'identified_only',<br/>
        cookieless_mode: 'always',<br/>
        disable_session_recording: true,<br/>
        enable_heatmaps: false,<br/>
    }<br/>
    </code>

    <h3 class="text-xl font-black font-normal pt-2">How We Use the Information</h3>
    <p>The anonymous analytics data we collect helps us understand how users interact with our site and make necessary enhancements. This data is used for the purpose of improving our website, and to provide site performance statistics.</p>

    <h3 class="text-xl font-black font-normal pt-2">Transparency</h3>

    <p>We believe in being transparent about our analytics. Basic statistics such as visitor counts and page views for the previous 3 months are always publicly available <a href="https://www.liquidglassresources.com/advertise/">on the website</a>.</p>

    <h3 class="text-xl font-black font-normal pt-2">Data Retention</h3>
    <p>Analytics data is retained according to PostHog Cloud's default retention policy, which is 1 year for free-tier plans. Since we do not collect personally identifiable information, no personal data is stored beyond what is described above.</p>

    <h3 class="text-xl font-black font-normal pt-2">Data Security & Privacy</h3>
    <p>Our legal basis for processing this data is legitimate interest, as we only collect anonymous, non-personal analytics to improve our website, and to provide site performance statistics.</p>

    <p>PostHog acts as a data processor on our behalf. We take reasonable measures to protect the security of the data collected. We've set up <a href="https://posthog.com/docs/privacy/gdpr-compliance#how-to-set-posthog-up-for-gdpr-compliance" target="_blank">Posthog for GDPR compliance</a>, and we're using <a href="https://posthog.com/eu" target="_blank">Posthog Cloud EU</a>: Posthog's hosting option in Frankfurt to keep Customer data in the EU.</p>

    <h3 class="text-xl font-black font-normal pt-2">Your Choices</h3>
    <p>Since we do not collect any personally identifiable information, there are no opt-out options or preferences to manage.</p>

    <h3 class="text-xl font-black font-normal pt-2">Changes to this Privacy Policy</h3>
    <p>We may update this Privacy Policy as needed to reflect changes in our data collection practices or legal requirements.</p>

    <h3 class="text-xl font-black font-normal pt-2">Contact Us</h3>
    <p>If you have any questions or concerns about our privacy practices or this Privacy Policy, you may contact us via email: <a href="mailto:hello@brew.dev">hello@brew.dev</a>.</p>

    <h3 class="text-xl font-black font-normal pt-2">Last updated</h3>
    <p>March 2026.</p>
</div>