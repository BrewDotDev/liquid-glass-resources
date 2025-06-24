---
layout: default
---
<div>
    <div class="grid grid-cols-3 gap-4 py-8">
        {% for post in site.posts %}
          	<div class="md:col-span-1 col-span-3 rounded-md border p-4 flex flex-col gap-1">
                <h2 class="text-xl">
          		    <a href="{{ post.url }}">{{ post.title }}</a>
                </h2>
                <p>Date added: {{ post.date | date: "%-d %B %Y" }}</p>
                <p>By <a href="{{ post.creator_url }}">{{ post.creator }}</a></p>
                <p>Category: {{ post.categories }}</p>
                <div class="flex flex-row gap-2">
                    {% for tag in post.tags %}
                        <p class="rounded-full text-sm px-2 py-1 bg-blue-100">
                            {{ tag }}
                        </p>
                    {% endfor %}
                </div>
        	</div>
        {% endfor %}
    </div>
</div>