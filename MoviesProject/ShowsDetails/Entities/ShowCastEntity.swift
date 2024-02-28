import Foundation

struct ShowCastEntity: Decodable {
    let personId: Int?
    let personName: String?
    let personImageMedium: String?
    let personCountry: String?
    let characterId: Int?
    let characterName: String?
    let characterImageMedium: String?
    
    enum CodingKeys: String, CodingKey {
        case person
        case character
    }
    
    enum PersonCodingKeys: String, CodingKey {
        case id
        case name
        case image
        case country
    }
    
    enum CharacterCodingKeys: String, CodingKey {
        case id
        case name
        case image
    }
    
    enum ImageCodingKeys: String, CodingKey {
        case medium
        case original
    }
    
    enum CountryCodingKeys: String, CodingKey{
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let personContainer = try container.nestedContainer(keyedBy: PersonCodingKeys.self, forKey: .person)
        
        if let personId = try? personContainer.decode(Int.self, forKey: .id){
            self.personId = personId
        }else{
            self.personId = 0
        }
        
        if let personName = try? personContainer.decode(String.self, forKey: .name){
            self.personName = personName
        }else{
            self.personName = ""
        }
                
        if let personImageContainer = try? personContainer.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .image){
            self.personImageMedium = try personImageContainer.decode(String.self, forKey: .medium)
        }else{
            self.personImageMedium = "https://static.vecteezy.com/system/resources/previews/024/983/914/non_2x/simple-user-default-icon-free-png.png"
        }
        
        if let countryContainer = try? personContainer.nestedContainer(keyedBy: CountryCodingKeys.self, forKey: .country){
            self.personCountry = try countryContainer.decode(String.self, forKey:.name)
        }else{
            self.personCountry = ""
        }
        
        let characterContainer = try container.nestedContainer(keyedBy: CharacterCodingKeys.self, forKey: .character)
        
        if let characterId = try? characterContainer.decode(Int.self, forKey: .id){
            self.characterId = characterId
        }else{
            self.characterId = 0
        }
        
        if let characterName = try? characterContainer.decode(String.self, forKey: .name){
            self.characterName = characterName
        }else{
            self.characterName = ""
        }

        if let characterImageContainer = try? characterContainer.nestedContainer(keyedBy: ImageCodingKeys.self, forKey: .image){
            self.characterImageMedium = try characterImageContainer.decode(String.self, forKey: .medium)
        }else{
            self.characterImageMedium = "https://static.vecteezy.com/system/resources/previews/024/983/914/non_2x/simple-user-default-icon-free-png.png"
        }
    }
}
