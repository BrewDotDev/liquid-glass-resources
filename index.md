---
layout: default
---
<div>
    <div class="grid grid-cols-3 gap-4">
        {% for post in site.posts %}
          	<div class="col-span-1 bg-blue-100">
                <h2 class="text-xl">
          		    <a href="{{ post.url }}">{{ post.title }}</a>
                </h2>
                <p>Date added: {{ post.date | date: "%-d %B %Y" }}</p>
                <p>By <a href="{{ post.creator_url }}">{{ post.creator }}</a></p>
                <p>Category: {{ post.categories }}</p>
                <p> Tags:
                    {% for tag in post.tags %}
                        {{ tag }}
                    {% endfor %}
                 </p>
        	</div>
        {% endfor %}
    </div>
</div>