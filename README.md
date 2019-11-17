# laravel_project, a Chef Cookbook

![GitHub](https://img.shields.io/github/license/djzara/laravel_project)
![GitHub](https://img.shields.io/github/issues/djzara/laravel_project)

# Why?

This started as me goofing around on a Saturday night wanting a quick change of scenery from my other projects. I was thinking
over to myself "I use Chef all the time, why not write my own library cookbook"? That's all well and good, but to do what?
What could I possibly want to do that would make sense for Chef?

Then it came to me, Laravel. That's the other project I use tons, and I love it to pieces. I hit up the supermarket and
looked around for anything Laravel, and only saw one for setting up Laravel 4 projects, and another for using artisan
commands inside a Chef provision. Well this sounds like a good start then.

## Why not Homestead?

Taylor did an amazing job with Homestead, and it's a wonderful way to get up and running quickly with Laravel. You could
say this is just another way to do it, and in a way that's as simple or as hard as you want to make it. Homestead provides
an entire dev environment out of the box, ready to go with Vagrant and VirtualBox, and everything you could ever need!

But there is something I wish I could do easier with Homestead. What if i wanted to hack around and build a box more
suitable to what I was actually trying to do, maybe something that fits within a particular organization's requirements
for software instead of the generic one Homestead provides (at time of writing)? Why not integrate it with a much,
much larger ecosystem that can be leveraged if desired? What if your prod OS is RHEL and you need to match that in true
Chef style? Sure, you can use the after.sh script, but I wanted to give another option.

Homestead is an amazing project, and definitely give it a look. It may work better for you than this, or maybe you'll
find something like this more to your liking. 
