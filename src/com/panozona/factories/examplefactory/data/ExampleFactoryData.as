/*
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
package com.panozona.factories.examplefactory.data{
	
	import com.panozona.player.module.data.ModuleDataFactory;
	import com.panozona.player.module.data.ModuleNode;
	import com.panozona.player.module.utils.ModuleDataTranslator;
	import com.panozona.factories.examplefactory.data.structure.Products;
	
	public class ExampleFactoryData{
		
		public var products:Products = new Products();
		
		public function ExampleFactoryData(moduleData:ModuleDataFactory, saladoPlayer:Object){
			
			var translator:ModuleDataTranslator = new ModuleDataTranslator(saladoPlayer.managerData.debugMode);
			
			for each(var moduleNode:ModuleNode in moduleData.nodes) {
				if (moduleNode.name == "products") {
					translator.moduleNodeToObject(moduleNode, products);
				}else {
					throw new Error("Invalid node name: " + moduleNode.name);
				}
			}
			
			if (saladoPlayer.managerData.debugMode){
				
			}
		}
	}
}