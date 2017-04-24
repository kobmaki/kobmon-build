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
// #include <boost/log/trivial.hpp>
#include <boost/program_options.hpp>

using namespace std;

int main (int argc, char **argv) {

  std::string aXmlStyle = "utf-8";

  // first option is the style sheet
  if (argc > 1 ) {
    aXmlStyle=argv[1];
    aXmlStyle="utf-8\"?>\n<?xml-stylesheet type=\"text/xsl\" href=\""+aXmlStyle;
  }

  boost::property_tree::ptree pt;
  try 
    {
      boost::property_tree::read_json(std::cin, pt);
    }
  catch(boost::exception const&  ex)
    {
      // BOOST_LOG_TRIVIAL(error) << "Error json2xml reading json format";
      std::cerr << "Error json2xml reading json format";
      return 1;
    }

  // set the style info, simple "trick"
   boost::property_tree::xml_writer_settings<char> settings('\t', 1, aXmlStyle);
   //   boost::property_tree::write_xml(std::cout, pt, boost::property_tree::xml_parser::trim_whitespace);
   boost::property_tree::write_xml(std::cout, pt, settings);
  return 0;
}
