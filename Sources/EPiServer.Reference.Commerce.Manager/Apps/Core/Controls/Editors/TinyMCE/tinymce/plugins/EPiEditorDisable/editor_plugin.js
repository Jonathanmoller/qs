(function(a,c){var b=a.dom.Event;a.create("tinymce.plugins.epieditordisable",{init:function(g,d){var e=g.settings.readonly;var f=this;f.editor=g;if(e){g.onInit.add(function(h,i){h.onNodeChange.add(function(m,l,k,j){f._setAllDisabled(true);});c(".mceStatusbar",h.getContainer()).addClass("disabled");});}},_setAllDisabled:function(d){var e=this,g=e.editor;var f;a.each(g.controlManager.controls,function(h){h.setDisabled(d);});},getInfo:function(){return{longname:"EPiServer Editor Disable",author:"EPiServer AB",authorurl:"http://www.episerver.com",infourl:"http://www.episerver.com",version:1};}});a.PluginManager.add("epieditordisable",a.plugins.epieditordisable);}(tinymce,epiJQuery));