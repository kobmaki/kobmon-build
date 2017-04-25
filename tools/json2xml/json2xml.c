/******************************************************************************
 * json2xml                                                                   *
 * Copyright (C) Uwe Ebel ( kobmaki @ aol com) , 2017                         *
 *                                                                            *
 * This program is free software; you can redistribute it and/or              *
 * modify it under the terms of the GNU General Public License                *
 * as published by the Free Software Foundation; either version 2             *
 * of the License, or (at your option) any later version.                     *
 *                                                                            *
 * This program is distributed in the hope that it will be useful,            *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of             *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              *
 * GNU General Public License for more details.                               *
 *                                                                            *
 * You should have received a copy of the GNU General Public License          *
 * along with this program; if not, write to the Free Software Foundation     *
 * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.             *
 ******************************************************************************/
#include <boost/property_tree/json_parser.hpp>  
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
using namespace std;

int showHelp(){
  std::cout << "json2xml [-h|-v|-s <xml-style-link>]\n";
}

int showVersion(){
  std::cout << "json2xml - version 0.1, kobmon-build, http://github.com/kobmaki/kobmon-build/\n";
}

int main (int argc, char **argv) {

  std::string aXmlStyle = "utf-8";
  std::string aOption = ""; // default empty

  if ( argc > 1 ) {
    aOption=argv[1];
  }

  // test all supported options
  if ( argc > 1
       && !( aOption.compare("-h") == 0 // help
	     || aOption.compare("-s") == 0 // style
	     || aOption.compare("-v") == 0 // version
	   )
      ) {
    std::cerr << "unsupported option, try json2xml -h\n";
    return 1;
  }

  if (aOption.compare("-h") == 0 ){
    showHelp();
    return 0;
  }

  if (aOption.compare("-v") == 0 ){
    showVersion();
    return 0;
  }

  if (argc < 3 && aOption.compare("-s") == 0 ){
    std::cerr << "required style add\n";
    return 1;
  }

  // second option is the style sheet
  if ( argc > 2 && aOption.compare("-s") == 0 ) {
    aXmlStyle=argv[2];
    aXmlStyle="utf-8\"?>\n<?xml-stylesheet type=\"text/xsl\" href=\""+aXmlStyle;
  }

  boost::property_tree::ptree pt;
  try 
    {
      boost::property_tree::read_json(std::cin, pt);
    }
  catch(boost::exception const&  ex)
    {
      std::cerr << "Error json2xml reading json format\n";
      return 1;
    }

  // set the style info, simple "trick"
   boost::property_tree::xml_writer_settings<char> settings('\t', 1, aXmlStyle);
   boost::property_tree::write_xml(std::cout, pt, settings);

  return 0;
}
