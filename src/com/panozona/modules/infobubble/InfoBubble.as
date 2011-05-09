﻿/*
Copyright 2011 Marek Standio.

This file is part of SaladoPlayer.

SaladoPlayer is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published
by the Free Software Foundation, either version 3 of the License,
or (at your option) any later version.

SaladoPlayer is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with SaladoPlayer. If not, see <http://www.gnu.org/licenses/>.
*/
package com.panozona.modules.infobubble{
	
	import com.panozona.modules.infobubble.controller.BubbleController;
	import com.panozona.modules.infobubble.model.InfoBubbleData;
	import com.panozona.modules.infobubble.view.BubbleView;
	import com.panozona.player.module.data.ModuleData;
	import com.panozona.player.module.Module;
	import flash.system.ApplicationDomain;
	
	public class InfoBubble extends Module{
		
		private var infoBubbleData:InfoBubbleData;
		
		private var bubbleView:BubbleView;
		private var bubbleController:BubbleController;
		
		public function InfoBubble(){
			super("InfoBubble", "1.1", "http://panozona.com/wiki/Module:InfoBubble");
			
			moduleDescription.addFunctionDescription("showBubble", String);
			moduleDescription.addFunctionDescription("hideBubble");
			moduleDescription.addFunctionDescription("setEnabled", Boolean);
			moduleDescription.addFunctionDescription("toggleEnabled");
		}
		
		override protected function moduleReady(moduleData:ModuleData):void {
			
			infoBubbleData = new InfoBubbleData(moduleData, saladoPlayer); // allways first
			
			bubbleView = new BubbleView(infoBubbleData);
			addChild(bubbleView);
			bubbleController = new BubbleController(bubbleView, this);
			
			var panoramaEventClass:Class = ApplicationDomain.currentDomain.getDefinition("com.panozona.player.manager.events.PanoramaEvent") as Class;
			saladoPlayer.manager.addEventListener(panoramaEventClass.PANORAMA_STARTED_LOADING, onPanoramaStartedLoading, false, 0, true);
		}
		
		private function onPanoramaStartedLoading(loadPanoramaEvent:Object):void {
			var panoramaEventClass:Class = ApplicationDomain.currentDomain.getDefinition("com.panozona.player.manager.events.PanoramaEvent") as Class;
			saladoPlayer.manager.removeEventListener(panoramaEventClass.PANORAMA_STARTED_LOADING, onPanoramaStartedLoading);
			if (infoBubbleData.settings.enabled) {
				saladoPlayer.manager.runAction(infoBubbleData.settings.onEnable);
			}else {
				saladoPlayer.manager.runAction(infoBubbleData.settings.onDisable);
			}
		}
		
///////////////////////////////////////////////////////////////////////////////
//  Exposed functions 
///////////////////////////////////////////////////////////////////////////////
		
		public function showBubble(bubbleId:String):void {
			infoBubbleData.bubbleData.currentBubbleId = bubbleId; // change id first!
			infoBubbleData.bubbleData.isShowingBubble = true;
		}
		
		public function hideBubble():void {
			infoBubbleData.bubbleData.isShowingBubble = false;
		}
		
		public function setEnabled(value:Boolean):void {
			infoBubbleData.bubbleData.enabled = value;
		}
		
		public function toggleEnabled():void {
			infoBubbleData.bubbleData.enabled = !infoBubbleData.bubbleData.enabled;
		}
	}
}