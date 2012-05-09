Forked from [angelo0000](https://github.com/angelo0000/backbone_filters).
This is the same plugin rewritten in CoffeeScript and wrapped as an AMD module.
It probably won't be useful to you but it is useful to me.

# Usage

Include `backbone_filters.js` after Backbone.

In your router you can now add:

```javascript
before: {
	'^clerks' : function() {
		/* do stuff to all routes starting with 'clerks' */
		/* return false to halt execution */
	},
	'another reg ex' : function() { }
},

after: {
	'^clerks' : function() {
		/* do stuff */
	},
	'another reg ex' : function() { }
}
```

Your filters will be called and if a filter returns false, the filter chain is halted.
If a before filter chain is halted, the action in the Router will not be called. Your
filters will receive the same arguments that get passed to the actions.