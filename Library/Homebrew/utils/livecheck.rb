# frozen_string_literal: true

require "open3"

module Livecheck
  def livecheck_formula_response(formula_name)
    puts "- livecheck formula : #{formula_name}"
    command_args = [
      "brew",
      "livecheck",
      formula_name,
      "--quiet"
    ]

    response = Open3.capture2e(*command_args)
    parse_livecheck_response(response)
  end

  def parse_livecheck_response(response)
    output = response.first.gsub(' ', '').split(/:|==>|\n/)

    # eg: ["burp", "2.2.18", "2.2.18"]
    package_name, brew_version, latest_version = output

    {'name' => package_name, 'current_brew_version' => brew_version, 'livecheck_latest_version' => latest_version}
  end
end
