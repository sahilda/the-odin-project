class XmlDocument

	def initialize (indent=false)
		@indent=indent
		@space=0
	end

	def method_missing(meth, *args, &block)
		attr = []
		if args[0]
			args[0].each do |key, value|
				attr.push("#{key.to_s}='#{value}'")
			end
		end

		if attr.size == 0
			tag = "<#{meth}"
		else
			tag = "<#{meth} #{attr.join(" ")}"
		end

		if block == nil
			if @indent
				tag += "/>\n"
			else
				tag += "/>"
			end
		else
			if @indent
				@space += 2
				tag += ">\n#{' '*@space}#{yield}#{' '*(@space - 2)}</#{meth}>\n"
				@space -= 2
			else
				tag += ">#{yield}</#{meth}>"
			end
		end

		tag
	end
end