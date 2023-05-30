# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Instructor.create!(name: 'Bruno Galvao', description: 'Bruno has a background in software engineering and product management. He’s worked extensively with JavaScript, Ruby, and Python applications in micro-service environments. Bruno strongly believes in adopting agile methodologies, software craftsmanship, test-driven development (TDD), code reviews, and pair-programming as a foundation for scalable defect-free code. In the past, he has worked for small startups building products and in large companies working on cross-functional, self-organizing, autonomous teams writing high-quality maintainable code. When he is not hacking away on his Macbook he enjoys going for long runs and practicing yoga. As a SEI Instructor Lead, he brings his experience and passion to the classroom preparing students for a life-long journey in software development!', link: 'https://linkedin.com/in/brunopgalvao', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/18686/thumb_bruno001.png')
Instructor.create!(name: 'Emre Surmeli', description: 'Emre is a software developer, a blockchain technology consultant, and an educator. Having gone through a full stack JavaScript boot camp in Seattle in 2015, he\'s passionate about accelerated learning programs and loves to take as well as teach them. Shortly after finishing his boot camp he worked at a tech startup building apps using node.js, Ruby/Rails, and AWS until October of 2018 when he decided to quit and try out digital nomad\'ing in Central America. He was introduced to Ethereum by his co-worker in late 2016, since then he spent most of his free time learning and researching about blockchain technologies and how to develop them. In the excitement of quickly realizing the imperative and inevitable role of blockchain in advancing specific technologies, he developed a blockchain workshop for GA. Emre has been combining his experience in web development and understanding of blockchain technologies to helping companies build blockchain applications.', link: 'https://www.linkedin.com/in/emresurmeli', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/19535/thumb_2wdvr76.png')
Instructor.create!(name: 'Steve VanWoerkom', description: 'Steven VanWoerkom is a Instructor Lead at General Assembly New York City. A passionate technologist, educator, and lifetime learner who loves guiding students on their career paths to becoming web developers.', link: 'https://www.linkedin.com/in/steven-vanwoerkom', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/18780/thumb_2uzxc85.jpg')
Instructor.create(name: 'Joe Keohan', description: 'Joe always had a passion for technology and after several years in the industry made the move into teaching Microsoft’s Server, Active Directory, and Sharepoint architectures. After working on a client project that involved Tableau and JavaScript, he was inspired to take GA’s Web Development Immersive Boot Camp where he made the decision to specialize in Data Visualization using D3.js. Upon graduation he worked on several D3 specific client projects before returning to GA as an instructor teaching their Front End Web Development and JavaScript evening classes. This ultimately led him into his current role as Lead Instructor for the WDI Bootcamp. He now spends his free time learning all things D3 while encouraging students to incorporate it into every project.', link: 'https://www.linkedin.com/in/jkeohan', photo: 'https://ga-core.s3.amazonaws.com/production/uploads/instructor/image/7866/thumb_headshot_gtt4a1.jpg')

puts "#{Instructor.count} instructors created!"